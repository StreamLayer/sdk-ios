//
//  ViewController.swift
//  SLRTVExample
//
//  Created by Kirill Kunst on 30.12.2025.
//

import UIKit
import StreamLayerSDKTVOS
import AVFoundation

enum PlayerPlayingState {
  case playing
  case paused
}

class ViewController: UIViewController {

  private var adBreakWorkItem: DispatchWorkItem?

  private lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var videoView: UIView = {
    let view = UIView()
    view.backgroundColor = .black
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private lazy var slrViewController: UIViewController = {
    let controller = StreamLayer.createOverlay(
      containerViewController: self,
      contentView: containerView,
      delegate: self
    )
    controller.view.translatesAutoresizingMaskIntoConstraints = false
    return controller
  }()

  private lazy var playPauseView: PlayPauseView = { [weak self] in
    let view = PlayPauseView(onTap: { [weak self] in
      guard let self, let player = player else { return }
      if player.timeControlStatus == .playing {
        handlePauseAction()
      } else if player.timeControlStatus == .paused {
        handlePlayAction()
      }
    })
    view.alpha = 0.6
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  private var player: AVPlayer?
  private var playerLayer: AVPlayerLayer?
  private var playerVolumeBeforeDucking: Float?

  override var preferredFocusEnvironments: [any UIFocusEnvironment] {
    [slrViewController, playPauseView]
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setupSDK()
    configureViews()
    makeConstraints()
    setupPlayer()
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    playerLayer?.frame = videoView.bounds
  }

  private func setupSDK() {
    StreamLayer.clearAuthCreds()

    // Session ID should be provided by your backend or from StreamLayer dashboard
    StreamLayer.createSession(for: "YOUR_SESSION_ID", timeCodeProvider: self)
  }

  private func setupPlayer() {
    // Example video URL
    guard let url = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else { return }
    
    let item = AVPlayerItem(url: url)
    player = AVPlayer(playerItem: item)
    let playerLayer = AVPlayerLayer(player: player)
    playerLayer.frame = videoView.bounds
    playerLayer.videoGravity = .resizeAspect
    videoView.layer.addSublayer(playerLayer)
    self.playerLayer = playerLayer
    
    player?.play()
    playPauseView.setState(.playing)
  }

  private func configureViews() {
    view.addSubview(containerView)
    containerView.addSubview(videoView)
    containerView.addSubview(playPauseView)

    slrViewController.willMove(toParent: self)
    addChild(slrViewController)
    containerView.addSubview(slrViewController.view)
    slrViewController.didMove(toParent: self)
  }

  private func makeConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: view.topAnchor),
      containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

      videoView.topAnchor.constraint(equalTo: containerView.topAnchor),
      videoView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      videoView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      videoView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),

      playPauseView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
      playPauseView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      playPauseView.widthAnchor.constraint(equalToConstant: 120),
      playPauseView.heightAnchor.constraint(equalToConstant: 120),

      slrViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
      slrViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
      slrViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
      slrViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
    ])
  }

  private func handlePlayAction() {
    playPauseView.setState(.playing)
    player?.play()
  }

    private func handlePauseAction() {
      playPauseView.setState(.paused)
      player?.rate = 0
      let adBreakWorkItem = DispatchWorkItem { [weak self] in
        guard self?.adBreakWorkItem?.isCancelled == false else { return }
        self?.handleAdBreak()
      }

      var timeout = 5.0
      #if DEBUG
        timeout = 0.5
      #endif
      DispatchQueue.main.asyncAfter(deadline: .now() + timeout, execute: adBreakWorkItem)
      self.adBreakWorkItem = adBreakWorkItem
    }

    private func handleAdBreak() {
        StreamLayer.showPausedAd(.transparentBackground(vastTagURL: URL(string: "https://storage.googleapis.com/roku.streamlayer.io/pause-ads/vast/pause_ad_vast.xml")!))
    }
}

// MARK: - StreamLayerTVOSDelegate
extension ViewController: StreamLayerTVOSDelegate {
  func updateDuckingState(_ enabled: Bool) {
    DispatchQueue.main.async { [weak self] in
      if self?.playerVolumeBeforeDucking == nil {
        self?.playerVolumeBeforeDucking = self?.player?.volume
      }

      if enabled {
        self?.player?.volume = 0.1
      } else {
        if let playerVolumeBeforeDucking = self?.playerVolumeBeforeDucking {
          self?.player?.volume = playerVolumeBeforeDucking
        }
        self?.playerVolumeBeforeDucking = nil
      }
    }
  }

  func didResumePlaying() {
    player?.play()
  }
}

// MARK: - SLRTimecodeProvider
extension ViewController: SLRTimecodeProvider {
  func getEpochTimeCodeInMillis() -> TimeInterval {
    guard let date = player?.currentItem?.currentDate() else {
      return Date().timeIntervalSince1970 * 1000
    }
    return date.timeIntervalSince1970 * 1000
  }
}
