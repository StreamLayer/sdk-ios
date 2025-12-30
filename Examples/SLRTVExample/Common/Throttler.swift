//
//  Throttler.swift
//  SLRExamples
//
//  Created by Kirill Kunst on 30.12.2025.
//
import Foundation

class Throttler {
  private var lastRunTime: Date = .distantPast
  private let minimumDelay: TimeInterval

  init(minimumDelay: TimeInterval) {
    self.minimumDelay = minimumDelay
  }

  func throttle(_ action: @escaping () -> Void) {
    let now = Date()
    if now.timeIntervalSince(lastRunTime) >= minimumDelay {
      lastRunTime = now
      action()
    }
  }
}

