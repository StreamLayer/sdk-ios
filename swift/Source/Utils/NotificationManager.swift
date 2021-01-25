//
// Created by Maxim Bunkov on 07/11/2018.
// Copyright (c) 2018 StreamLayer, Inc. All rights reserved.
//

import Foundation

final class NotificationManager: NSObject {
  let notificationCenter: NotificationCenter
  let token: Any

  init(notificationCenter: NotificationCenter = .default, token: Any) {
    self.notificationCenter = notificationCenter
    self.token = token
  }

  deinit {
    notificationCenter.removeObserver(token)
  }
}

extension NotificationCenter {
  /// Convenience wrapper for addObserver(forName:object:queue:using:)
  /// that returns our custom NotificationToken.
  func subscribe(name: NSNotification.Name?, object obj: Any?,
                 queue: OperationQueue?, using block: @escaping (Notification) -> Void)
                  -> NotificationManager {
    let token = addObserver(forName: name, object: obj, queue: queue, using: block)
    return NotificationManager(notificationCenter: self, token: token)
  }
}
