//
// Created by Maxim Bunkov on 27/10/2018.
// Copyright (c) 2019 StreamLayer, Inc. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreMedia
import StreamLayer
import StreamLayerVendor
import RxSwift
import PromiseKit
import GRPC
import NIOConcurrencyHelpers
import slVendorObjc
import XCDYouTubeKit

#if os(iOS)
import AVKit
#endif

public enum SLRVideoPlayerProviderType {
  case vimeo
  case youtube
}

public class SLRVideoPlayer: UIViewController {
  #if os(iOS)
  private let playerController = AVPlayerViewController()
  public var onTap: Observable<UITapGestureRecognizer>!
  #elseif os(tvOS)
  private var playerLayer = AVPlayerLayer()
  #endif

  private let lock = Lock()
  private let disposeBag = DisposeBag()
  private var player: AVPlayer!
  private var notificationManager: NotificationManager?

  public var switchStreamHandler: ((String) -> Void)?

  // tracks requests for ducking
  fileprivate var volumeReductionRequests: Int = 0
  fileprivate let volumeReduceRate: Float = 0.1
  fileprivate var playerVolumeOriginal: Float = 1

  // tracks requests for audio sessions
  fileprivate var kTotalSessions: Int { return kGenericSessions + kGenericSessions }
  fileprivate var kGenericSessions: Int = 0
  fileprivate var kVoiceSessions: Int = 0

  // url for the youtube video
  var contentVideoIdString: String!
  var video: CancellablePromise<URL>!
  private var providerType: SLRVideoPlayerProviderType = .vimeo

  deinit {
    if video?.isPending == true {
      video.cancel()
    }
  }

  public convenience init(withURL url: String, providerType: SLRVideoPlayerProviderType = .vimeo) {
    self.init()
    self.providerType = providerType
    self.contentVideoIdString = url
    self.resolveVideo()
  }

  private func resolveVideo() {
    if self.video != nil && self.video.isPending {
      self.video.cancel()
      self.video = nil
    }
    switch providerType {
    case .vimeo:
      self.video = Promise { seal in
        YTVimeoExtractor.shared().fetchVideo(withIdentifier: self.contentVideoIdString, withReferer: nil) {
          seal.resolve($0?.httpLiveStreamURL ?? $0?.highestQualityStreamURL() ?? $0?.lowestQualityStreamURL(), $1)
        }
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
    }
  }

  public func deactivate() {
    player?.pause()
  }

  private func processVideoResolution() {
    video.done {
      if self.player == nil {
        self.loopVideo(in: AVPlayer(url: $0))
      } else {
        self.playVideo()
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

  public func setNewStreamURL(withURL url: String, providerType: SLRVideoPlayerProviderType) {
    self.contentVideoIdString = url
    self.player = nil
    self.providerType = providerType
    self.resolveVideo()
    self.processVideoResolution()
  }

  #if os(tvOS)
  public override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    playerLayer.frame = view.layer.bounds
  }
  #endif

  override public func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear

    UIApplication.shared
      .rx.applicationDidBecomeActive
      .subscribe(onNext: { [weak self] _ in
        if self?.player?.timeControlStatus == .paused {
          self?.playVideo()
        }
      })
      .disposed(by: disposeBag)

    #if os(iOS)
    playerController.entersFullScreenWhenPlaybackBegins = false
    playerController.showsPlaybackControls = false
    playerController.videoGravity = .resizeAspect
    playerController.willMove(toParent: self)

    addChild(playerController)
    view.addSubview(playerController.view)
    playerController.didMove(toParent: self)

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

    #elseif os(tvOS)
    view.layer.addSublayer(playerLayer)
    view.isUserInteractionEnabled = false
    #endif
  }

  private func loopVideo(in avplayer: AVPlayer) {
    player = avplayer

    #if os(iOS)
    playerController.player = player
    #elseif os(tvOS)
    playerLayer.player = player
    #endif
    player.actionAtItemEnd = .none
    player.automaticallyWaitsToMinimizeStalling = true
    prepareAudioSession(for: .generic)
    playVideo()
    notificationManager = NotificationCenter.default.subscribe(
      name: .AVPlayerItemDidPlayToEndTime,
      object: player.currentItem,
      queue: OperationQueue.current) { [weak self] _ in
        self?.player?.seek(to: .zero)
        self?.player?.play()
    }

    // Example observe SLR notifications
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(handleInterruption(notification:)),
                                           name: AVAudioSession.interruptionNotification, object: nil)

  }

  @objc func handleInterruption(notification: Notification) {
    guard let userInfo = notification.userInfo,
      let interruptionTypeRawValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
      let interruptionType = AVAudioSession.InterruptionType(rawValue: interruptionTypeRawValue) else {
        return
    }
    switch interruptionType {
    case .began:
      pauseVideo()
    case .ended:
      playVideo()
    @unknown default:
      assertionFailure("\(interruptionType) unexpected")
    }
  }

  public func playVideo() {
    player?.play()
  }

  public func pauseVideo() {
    player?.pause()
  }

  public func playPause(source: UITapGestureRecognizer? = nil) {
    switch player.timeControlStatus {
    case .waitingToPlayAtSpecifiedRate:
      print("video stalled")
    case .paused: playVideo()
    case .playing: pauseVideo()
    @unknown default:
      assertionFailure("\(player.timeControlStatus) unexpected")
    }
  }
}

extension SLRVideoPlayer: SLROverlayDelegate {
  
  public func getVideoPlayerContainer() -> SLRVideoPlayerOverlayContainer? {
    nil
  }
  
  public func shareInviteMessage() -> String {
    return "You have received a test message from StreamLayer. Please disregard. Thanks"
  }

  public func waveMessage() -> String {
// TODO_ maybe simplify this wave message for the demo
//    let clientApp = Bundle.main.infoDictionary![kCFBundleNameKey as String] as? String ?? ""
//    let overlayState = StreamLayer.shared.redux.state.overlayState
//    let awayTeamName = overlayState.currentStreamParams?.awayTeamName ?? ""
//    let homeTeamName = overlayState.currentStreamParams?.homeTeamName ?? ""

//    return """
//           Hey! I’m watching the \(awayTeamName) vs \(homeTeamName) game right now in \
//           the \(clientApp) app new interactive group viewing features. Let's hang out and watch together!
//           """
    return ":)"
  }

  public func requestAudioDucking() {
    lock.withLockVoid {
      volumeReductionRequests += 1
      if volumeReductionRequests == 1, let player = player {
        playerVolumeOriginal = player.volume
        player.volume = volumeReduceRate * player.volume
        print("[ducking] on: \(player.volume))")
      }
    }
  }

  public func disableAudioDucking() {
    lock.withLockVoid {
      volumeReductionRequests -= 1
      if volumeReductionRequests == 0, let player = player {
        player.volume = playerVolumeOriginal
        print("[ducking] off: \(player.volume)")
      }
    }
  }

  public func disableAudioSession(for type: SLRAudioSessionType) {
    lock.lock()
    defer {
      print("[AudioSession] disable kVoiceSessions: \(kVoiceSessions), kGenericSessions: \(kGenericSessions)")
      lock.unlock()
    }

    switch type {
    case .voice: kVoiceSessions -= 1
    case .generic: kGenericSessions -= 1
    }

    // no sessions at all - disable
    if kTotalSessions == 0 {
      do {
//        try StreamLayer.closeAudioSession()
      } catch let error {
        print("[RPC] Error: \(error)")
        return
      }
      return
    }

    if kVoiceSessions > 0 {
      return
    }

    if type == .voice {
      do {
        try StreamLayer.prepareSessionForGeneralAudio(reactivate: false)
      } catch let error {
        print("[RPC] Error: \(error)")
        return
      }
    }
  }

  public func prepareAudioSession(for type: SLRAudioSessionType) {
    lock.lock()
    defer {
      print("[AudioSession] prepare kVoiceSessions: \(kVoiceSessions), kGenericSessions: \(kGenericSessions)")
      lock.unlock()
    }

    switch type {
    case .voice:
      kVoiceSessions += 1
      if kVoiceSessions == 1 {
        // There was some logic of reactivation of voice session, but apparently we do not need it as VoxImplant handles that.
        // So for now we just count sessions.
      }

    case .generic:
      kGenericSessions += 1
      if kGenericSessions > 0, kVoiceSessions == 0 {
        let reactivate = kGenericSessions == 1
        do {
          try StreamLayer.prepareSessionForGeneralAudio(reactivate: reactivate)
        } catch let error {
          print("[RPC] Error: \(error)")
          return
        }
        return
      }
    }
  }

  public func overlayOpened() {
    print("overlay opened")
  }

  public func overlayClosed() {
    print("overlay closed")
  }

  public func switchStream(to streamId: String) {
    self.switchStreamHandler?(streamId)
  }
  
}
