//
//  DemoPlayer.swift
//  Demo
//
//  Created by Kirill Kunst on 20.07.22.
//

import Foundation
import UIKit
import AVFoundation
import AVKit
import StreamLayer
import StreamLayerVendor

public class DemoVideoPlayer: UIViewController {
  private let playerController = AVPlayerViewController()
  private var player: AVPlayer!
  
  private var originalVolume: Float = 0.0

  override public func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear

    playerController.entersFullScreenWhenPlaybackBegins = false
    playerController.videoGravity = .resizeAspect
    playerController.willMove(toParent: self)
    playerController.showsPlaybackControls = true

    addChild(playerController)
    view.addSubview(playerController.view)
    playerController.didMove(toParent: self)
  }

  private func loopVideo(in avPlayer: AVPlayer) {
    player = avPlayer
    originalVolume = player.volume
    playerController.player = player
    player.actionAtItemEnd = .none
    player.automaticallyWaitsToMinimizeStalling = true
    player.play()
  }
  
  public func set(url: URL) {
    loopVideo(in: AVPlayer(url: url))
  }
  
  
  func makeQuiter() {
    player.volume = originalVolume * 0.1
  }
  
  func makeLouder() {
    player.volume = originalVolume
  }
}
