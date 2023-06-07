//
//  AVPlayer+Rx.swift
//  Demo
//
//  Created by Kirill Kunst on 07.06.2023.
//

import Foundation
import RxSwift
import RxCocoa
import AVFoundation

// MARK: - KVO
extension Reactive where Base: AVPlayer {

  var status: Observable<AVPlayer.Status> {
    return self
      .observe(AVPlayer.Status.self, #keyPath(AVPlayer.status))
      .map { $0 ?? .unknown }
  }

  var error: Observable<NSError?> {
    return self
      .observe(NSError.self, #keyPath(AVPlayer.error))
  }

  @available(iOS 10.0, *)
  var timeControlStatus: Observable<AVPlayer.TimeControlStatus> {
    return self
      .observe(AVPlayer.TimeControlStatus.self, #keyPath(AVPlayer.timeControlStatus))
      .map { $0 ?? .paused }
  }

  var rate: Observable<Float> {
    return self
      .observe(Float.self, #keyPath(AVPlayer.rate))
      .map { $0 ?? 0 }
  }

  var currentItem: Observable<AVPlayerItem?> {
    return self
      .observe(AVPlayerItem.self, #keyPath(AVPlayer.currentItem))
  }

  var actionAtItemEnd: Observable<AVPlayer.ActionAtItemEnd> {
    return self
      .observe(AVPlayer.ActionAtItemEnd.self, #keyPath(AVPlayer.actionAtItemEnd))
      .map { $0 ?? .none }
  }

  // MARK: - AVPlayerMediaControl

  var volume: Observable<Float> {
    return self
      .observe(Float.self, #keyPath(AVPlayer.volume))
      .map { $0 ?? 0 }
  }

  var muted: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayer.isMuted))
      .map { $0 ?? false }
  }

  // MARK: - AVPlayerExternalPlaybackSupport

  var allowsExternalPlayback: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayer.allowsExternalPlayback))
      .map { $0 ?? false }
  }

  var externalPlaybackActive: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayer.isExternalPlaybackActive))
      .map { $0 ?? false }
  }

  // swiftlint:disable identifier_name
  var usesExternalPlaybackWhileExternalScreenIsActive: Observable<Bool> {
    return self
      .observe(Bool.self, #keyPath(AVPlayer.usesExternalPlaybackWhileExternalScreenIsActive))
      .map { $0 ?? false }
  }
  // swiftlint:enable identifier_name
}
