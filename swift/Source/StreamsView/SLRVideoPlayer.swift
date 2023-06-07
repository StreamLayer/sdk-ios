//
// Created by Maxim Bunkov on 27/10/2018.
// Copyright (c) 2019 StreamLayer, Inc. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreMedia
import StreamLayer
import PromiseKit
import RxSwift
import RxRelay
import RxCocoa
import RxGesture
import RxSwiftExt
import RxAppState
import XCDYouTubeKit
import NIOConcurrencyHelpers
import AVKit

// swiftlint:disable switch_case_alignment file_length
public class SLRVideoPlayer: UIViewController {

  private static var streamVolume: Float = 1.0

  private let lock = NIOLock()
  private let disposeBag = DisposeBag()
  private var statusDisposeBag = DisposeBag()
  private var player: AVPlayer?
  private var notificationManager: NotificationManager?
  private var forcedPlayRequired: Bool = false
  private var userInitiatedPause: Bool = false
  private var sessionCategoryChangedToPlayback: Bool = false
  private var delayedPlayerForcedPlayWorkItem: DispatchWorkItem?

  // tracks requests for ducking
  private let volumeReduceRate: Float = 0.1
  private var playerVolumeOriginal: [Float] = []

  // tracks requests for audio sessions
  private var kTotalSessions: Int { return kGenericSessions + kGenericSessions }
  private var kGenericSessions: Int = 0
  private var kVoiceSessions: Int = 0

  private var providerType: StreamLayer.SLRVideoPlayerProviderType = .vimeo
  private var previousTimestamp: CMTime?

  private var playerLayer = AVPlayerLayer()
  private var pipController: AVPictureInPictureController?

  internal let timeControlStatus = BehaviorRelay<AVPlayer.TimeControlStatus>(value: .waitingToPlayAtSpecifiedRate)
  internal var onTap: Observable<UITapGestureRecognizer>!

  // url for the youtube video
  var contentVideoIdString: String!
  var videoStartTime: TimeInterval = 0
  var video: CancellablePromise<URL>!

  public var onPlayerVolumeChange: (() -> Void)?

  public var switchStreamHandler: ((String) -> Void)?
  public var isOverlayPresented = false

  // MARK: - Views

  private lazy var playerController: AVPlayerViewController = {
    let playerController = AVPlayerViewController()
    playerController.entersFullScreenWhenPlaybackBegins = false
    playerController.showsPlaybackControls = false
    playerController.videoGravity = .resizeAspect
    playerController.willMove(toParent: self)
    return playerController
  }()

  private let loadingIndicator: UIActivityIndicatorView = {
    let view = UIActivityIndicatorView()
    view.style = .large
    view.color = .white
    return view
  }()

  private weak var viewControllerRef: UIViewController?

  // MARK: - Init

  public convenience init(withURL url: String, viewControllerRef: UIViewController?, providerType: StreamLayer.SLRVideoPlayerProviderType = .vimeo) {
    self.init()
    self.viewControllerRef = viewControllerRef
    self.providerType = providerType
    self.contentVideoIdString = url
    self.resolveVideo()
  }

  deinit {
    if video?.isPending == true {
      video.cancel()
    }
  }

  // MARK: - Lifecycle

  override public func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear

    observeAppState()
    observeRouteChange()
    setupGestures()

    addChild(playerController)
    view.addSubview(playerController.view)
    playerController.didMove(toParent: self)
    view.addSubview(loadingIndicator)
    loadingIndicator.snp.makeConstraints {
      $0.center.equalToSuperview()
    }
  }

  // MARK: - Public

  public func setNewStreamURL(withURL url: String, startTime: TimeInterval, providerType: StreamLayer.SLRVideoPlayerProviderType) {
    userInitiatedPause = false
    contentVideoIdString = url
    videoStartTime = startTime
    player?.pause()
    player = nil
    self.providerType = providerType
    resolveVideo()
    processVideoResolution()
    previousTimestamp = nil
  }

  public func deactivate() {
    pauseUserVideo()
  }

  // MARK: - Private

  // MARK: - Setup

  private func setupGestures() {
    onTap = view.rx
      .tapGesture { tap, _ in
        tap.cancelsTouchesInView = false
      }
      .when(.recognized)

    view
      .rx
      .tapGesture { tap, _ in
        tap.numberOfTapsRequired = 2
        tap.cancelsTouchesInView = false
      }
      .when(.recognized)
      .subscribe(onNext: { [weak self] _ in
        switch self?.playerController.videoGravity {
          case .resizeAspect?: self?.playerController.videoGravity = .resizeAspectFill
          default: self?.playerController.videoGravity = .resizeAspect
        }
      })
      .disposed(by: disposeBag)
  }

  private func observeRouteChange() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(onRouteChangeEvent(notification:)),
      name: AVAudioSession.routeChangeNotification,
      object: nil
    )
  }

  private func observeAppState() {
    // https://developer.apple.com/documentation/avfoundation/media_playback/creating_a_basic_video_player_ios_and_tvos/playing_audio_from_a_video_asset_in_the_background
    UIApplication.shared
      .rx.applicationDidBecomeActive
      .subscribe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        guard let self = self, let player = self.player else { return }
        self.playerController.player = player
        if self.player?.timeControlStatus == .paused {
          self.playUserVideo()
        }
      })
      .disposed(by: disposeBag)

//    UIApplication.shared.rx.applicationDidEnterBackground
//      .subscribe(on: MainScheduler.instance)
//      .subscribe(
//        onNext: { [weak self] _ in
//          self?.setupPictureInPicture()
//        }
//      ).disposed(by: disposeBag)
  }

  @objc
  private func onRouteChangeEvent(notification: Notification) {
    // AVPlayer monitors app’s audio session and responds appropriately to route changes.
    // It pauses all media if session was deactivated
    // As a workaround we can start delayed check of a player status and try to force play it
    guard let reason = notification.userInfo?[AVAudioSessionRouteChangeReasonKey] as? UInt else {
      return
    }

    guard reason == AVAudioSession.RouteChangeReason.categoryChange.rawValue else {
      return
    }
    if AVAudioSession.sharedInstance().category == .playback {
      sessionCategoryChangedToPlayback = true
    }
  }

  @objc
  private func handleInterruption(notification: Notification) {
    guard let userInfo = notification.userInfo,
          let interruptionTypeRawValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
          let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeRawValue) else {
      return
    }
    switch interruptionType {
      case .began:
        pauseUserVideo()
      case .ended:
        playUserVideo()
      @unknown default:
        assertionFailure("\(interruptionType) unexpected")
    }
  }

  // https://developer.apple.com/documentation/avkit/adopting_picture_in_picture_in_a_custom_player
  private func setupPictureInPicture() {
    guard AVPictureInPictureController.isPictureInPictureSupported() else {
      restoreVideoPlayback()
      return
    }
    // TODO: Because we have a sync issue. Where we should start tinode sync each connect to the internet.
    // We can't use PiP, currently. After each time when user close the PiP controleer iOS disconect our app.
    // Therefore it call 'sync' again, and make our app freeze and crash.
    // For now we shoudl set playerController.player to nil. For prevetn PiP autostart.
    playerController.player = nil
    // also we should not setup playerLayer.player = player, or PiP will call disconnect on network layer.

//    playerLayer.player = player

    pipController = AVPictureInPictureController(playerLayer: playerLayer)
    pipController?.delegate = self
  }

  private func forcePlayVideo() {
    guard forcedPlayRequired else {
      return
    }

    guard player?.timeControlStatus == .paused else {
      delayedPlayerForcedPlayWorkItem?.cancel()
      delayedPlayerForcedPlayWorkItem = nil
      sessionCategoryChangedToPlayback = false
      forcedPlayRequired = false
      return
    }
    playUserVideo(true)

    let delayedCheck = DispatchWorkItem(block: { [weak self] in
      self?.forcePlayVideo()
    })

    delayedPlayerForcedPlayWorkItem = delayedCheck

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1,
                                  execute: delayedCheck)
  }

  private func restoreVideoPlayback() {
    guard let player = player else { return }

    playerLayer.player = nil
    pipController = nil

    if player.timeControlStatus == .paused {
      playUserVideo()
    }
  }
}

// MARK: - Video setup
private extension SLRVideoPlayer {
  func resolveVideo() {
    if self.video != nil && self.video.isPending {
      self.video.cancel()
      self.video = nil
    }
    switch providerType {
      case .vimeo:
        self.video = Promise { seal in
//          YTVimeoExtractor.shared().fetchVideo(withIdentifier: self.contentVideoIdString, withReferer: nil) {
//            seal.resolve($0?.httpLiveStreamURL ?? $0?.highestQualityStreamURL() ?? $0?.lowestQualityStreamURL(), $1)
//          }
        }.asCancellable()
      case .youtube:
        self.video = Promise { seal in
          XCDYouTubeClient.default().getVideoWithIdentifier(self.contentVideoIdString, completionHandler: {
            seal.resolve(
              $0?.streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? $0?.streamURLs[XCDYouTubeVideoQuality.HD720
                .rawValue],
              $1)
          })
        }.asCancellable()
      case .avPlayer:
        self.video = Promise { seal in
          seal.resolve(.fulfilled(URL(string: self.contentVideoIdString)!))
        }.asCancellable()
    }
  }

  func loopVideo(in avplayer: AVPlayer, seekTo: TimeInterval) {
    player = avplayer

    playerController.player = player
    player?.actionAtItemEnd = .none
    player?.automaticallyWaitsToMinimizeStalling = true
    player?.volume = Self.streamVolume
    prepareAudioSession(for: .generic)
    let start = CMTime(seconds: seekTo, preferredTimescale: 1)
    player?.seek(to: start, toleranceBefore: .zero, toleranceAfter: .zero)
    playUserVideo()
    notificationManager = NotificationCenter.default.subscribe(
      name: .AVPlayerItemDidPlayToEndTime,
      object: player?.currentItem,
      queue: OperationQueue.current) { [weak self] _ in
        self?.player?.seek(to: start, toleranceBefore: .zero, toleranceAfter: .zero)
        self?.playUserVideo()
      }

    statusDisposeBag = DisposeBag()

    player?.rx.timeControlStatus.withPrevious()
      .observe(on: MainScheduler.instance)
      .subscribe(onNext: { [weak self] (previous, current) in
        self?.timeControlStatus.accept(current)
        guard let previous = previous else {
          self?.loadingIndicator.stopAnimating()
          return
        }
        if previous != current {
          if current == .playing || current == .paused {
            self?.loadingIndicator.stopAnimating()
          } else {
            self?.loadingIndicator.startAnimating()
          }
          if previous == .playing,
             current == .paused,
             self?.forcedPlayRequired == true,
             self?.sessionCategoryChangedToPlayback == true {

            DispatchQueue.main.async { [weak self] in
              self?.forcePlayVideo()
            }
          }
        }
      })
      .disposed(by: statusDisposeBag)
  }

  func processVideoResolution() {
    video.done {
      if self.player == nil {
        self.loopVideo(in: AVPlayer(url: $0), seekTo: self.videoStartTime)
      } else {
        self.playUserVideo()
      }
    }.catch { [weak self] err in
      if err.isCancelled || self == nil {
        return
      }
      let alert = UIAlertController(title: "Video Failure", message: err.localizedDescription, preferredStyle: .alert)
      let dismiss = UIAlertAction(title: "ok", style: .cancel, handler: nil)
      let retry = UIAlertAction(title: "retry", style: .default) { [weak self] _ in
        self?.resolveVideo()
        self?.processVideoResolution()
      }

      alert.addAction(retry)
      alert.addAction(dismiss)

      self?.present(alert, animated: true, completion: nil)
    }
  }

}

// MARK: - Control video
extension SLRVideoPlayer {
  public func playUserVideo(_ userInitiated: Bool = false) {
    if userInitiatedPause && !userInitiated { return }
    player?.volume = Self.streamVolume
    player?.play()
    forcedPlayRequired = true
  }

  public func pauseUserVideo(_ userInitiated: Bool = false) {
    player?.pause()
    player?.volume = 1
    forcedPlayRequired = false
    userInitiatedPause = userInitiated
  }

  public func getPlayerVolume() -> Float {
    Self.streamVolume
  }

  public func setPlayerVolume(_ volume: Float) {
    guard let player = player else { return }
    Self.streamVolume = volume
    guard player.timeControlStatus == .playing else { return }
    player.volume = volume
  }

  public func seekVideo(to time: TimeInterval, savePrevious: Bool) {
    if previousTimestamp == nil || savePrevious {
      previousTimestamp = player?.currentTime()
    }
    loadingIndicator.startAnimating()

    let seekTime = CMTime(seconds: time, preferredTimescale: 1)
    player?.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
    playUserVideo()
  }
}

// MARK: - SLROverlayDelegate
extension SLRVideoPlayer: SLROverlayDelegate {

  public func pauseVideo(_ userInitiated: Bool) {
    pauseUserVideo()
  }

  public func playVideo(_ userInitiated: Bool) {
    playUserVideo()
  }

  public func currentPresentingViewController() -> UIViewController? {
    return viewControllerRef
  }

  public func getVideoPlayerContainer() -> SLRVideoPlayerOverlayContainer? {
    let containerPlayer = SLRVideoPlayerOverlayContainer(view.superview)
    return containerPlayer
  }

  public func shareInviteMessage() -> String {
    guard let clientApp = Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String else {
      return NSLocalizedString("Hey! You're invited to my Watch Party! Let's hang out and watch the game together:",
                               comment: "")
    }
    let message = NSLocalizedString(" Let's watch the <AppName> together! Join my watch party on the <AppName> app.",
                                    comment: ""
    )
    switch StreamLayer.config.appStyle {
      case .blue:
        return message.replacingOccurrences(of: "<AppName>", with: clientApp)
      case .green:
        return message.replacingOccurrences(of: "<AppName>", with: "Masters")
    }
  }

  public func waveMessage() -> String {
    return """
           Hey! Just got here!
           """
  }

  public func requestAudioDucking() {
    lock.withLockVoid {
      if let player = player {
        let isDuckingActive = playerVolumeOriginal.last.map({ Self.streamVolume == volumeReduceRate * $0 }) ?? false
        playerVolumeOriginal.append(Self.streamVolume)
        if !isDuckingActive {
          Self.streamVolume = volumeReduceRate * Self.streamVolume
        }
        onPlayerVolumeChange?()
        if player.timeControlStatus == .playing {
          player.volume = Self.streamVolume
        }
      }
    }
  }

  public func disableAudioDucking() {
    lock.withLockVoid {
      if playerVolumeOriginal.count > 0, let player = player {
        Self.streamVolume = playerVolumeOriginal.popLast() ?? 1
        onPlayerVolumeChange?()
        if player.timeControlStatus == .playing {
          player.volume = Self.streamVolume
        }
      }
    }
  }

  public func disableAudioSession(for type: SLRAudioSessionType) {
    lock.lock()
    defer {
      lock.unlock()
    }

    switch type {
      case .voice: kVoiceSessions -= 1
      case .generic: kGenericSessions -= 1
    }

    // no sessions at all - disable
    if kTotalSessions == 0 {
      try? StreamLayer.closeAudioSession()
    }
  }

  public func prepareAudioSession(for type: SLRAudioSessionType) {
    lock.lock()
    defer {
      lock.unlock()
    }

    switch type {
      case .voice:
        kVoiceSessions += 1
      case .generic:
        kGenericSessions += 1
        if kGenericSessions > 0, kVoiceSessions == 0 {
          let reactivate = kGenericSessions == 1
          try? StreamLayer.prepareSessionForGeneralAudio(reactivate: reactivate)
          return
        }
    }
  }

  public func overlayOpened() {
    isOverlayPresented = true
  }

  public func overlayClosed() {
    DispatchQueue.main.async { [weak self] in
      self?.isOverlayPresented = false
    }
  }

  public func switchStream(to streamId: String) {
    self.switchStreamHandler?(streamId)
  }

  public func mute() {
    guard let player = player else { return }
    playerVolumeOriginal.append(player.volume)
    player.volume = 0
  }

  public func unmute() {
    guard let player = player else { return }
    player.volume = playerVolumeOriginal.popLast() ?? 1
  }
}

extension SLRVideoPlayer: SLRTimecodeProvider {
  public func getEpochTimeCodeInMillis() -> TimeInterval {
    guard let date = player?.currentItem?.currentDate() else {
      return 0.0
    }

    return date.timeIntervalSince1970
  }
}

// MARK: - SLRTimeObservable
extension SLRVideoPlayer: SLRTimeObservable {
  public func addPeriodicTimeObserver(forInterval interval: CMTime, using block: @escaping (CMTime) -> Void) -> Any {
    return player?.addPeriodicTimeObserver(forInterval: interval, queue: nil, using: block) as Any
  }

  public func removeTimeObserver(_ observer: Any) {
    player?.removeTimeObserver(observer)
  }

  public func currentTime() -> CMTime {
    return player?.currentTime() ?? CMTime.zero
  }
}

extension SLRVideoPlayer: AVPictureInPictureControllerDelegate {
   public func pictureInPictureController(
     _ pictureInPictureController: AVPictureInPictureController,
     restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completion: @escaping (Bool) -> Void
   ) {
     restoreVideoPlayback()
     completion(true)
   }
}

// MARK: - ObservableType `withPrevious()`
private extension ObservableType {
  func withPrevious() -> Observable<(Element?, Element)> {
    return scan([], accumulator: { (previous, current) in
      Array(previous + [current]).suffix(2)
    })
    .map({ (arr) -> (previous: Element?, current: Element) in
      (arr.count > 1 ? arr.first : nil, arr.last!)
    })
  }
}
