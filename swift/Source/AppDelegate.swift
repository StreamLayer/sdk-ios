//
//  AppDelegate.swift
//

import UIKit
import UserNotifications
import StreamLayerSDK
import RxSwift

/// SDK key can be created in the StreamLayer admin panel. Check the official documentation for the relevant link.
/// You MUST use your own key.
let sdkKey = "sdkKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  fileprivate let window = UIWindow()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication .LaunchOptionsKey: Any]?) -> Bool {
    
    setupStreamLayer(launchOptions: launchOptions)

    let vc = DemoScreenViewController()
    window.rootViewController = vc
    window.makeKeyAndVisible()

    return true
  }

}

extension AppDelegate {
  func setupStreamLayer(launchOptions: [UIApplication .LaunchOptionsKey: Any]? = nil) {
    let key = Bundle.main.object(forInfoDictionaryKey: sdkKey) as? String ?? ""
    StreamLayer.initSDK(with: key, delegate: self)
      StreamLayer.config.phoneContactsSyncEnabled = false
      StreamLayer.config.shouldIncludeTopGestureZone = false
      StreamLayer.config.whoIsWatchingEnabled = false
      StreamLayer.config.notificationsMode = [.vote, .promotion, .twitter]
    Task {
      do {
        try await StreamLayer.useAnonymousAuth()
      } catch {
        print("[ANONYMOUS_AUTH] error: \(error)")
      }
    }
  }
}

extension AppDelegate: StreamLayerDelegate {
  func watchPartyInviteOpened(invite: SLRInviteData, completion: @escaping (Bool) -> Void) {
    // do nothing
  }
  
  func requireAuthentication(completion: @escaping (Bool) -> Void) {
    guard let vc = window.topViewController else { return }

    let provider = StreamLayerProvider()
    let authFlow = SLRAuthFlow(authProvider: provider)

    authFlow.show(from: vc) { _ in
      completion(false)
    }
  }
  
  func requireNameInput(completion: @escaping (Bool) -> Void) {
    guard let vc = window.topViewController else { return }

    let provider = StreamLayerProvider()
    let authFlow = SLRAuthFlow(authProvider: provider)

    authFlow.showNameInput(from: vc) { res in
      completion(res != nil)
    }
  }
}


extension UIWindow {
  var topViewController: UIViewController? {
    var topMostViewController = self.rootViewController
    while let presentedViewController = topMostViewController?.presentedViewController {
      topMostViewController = presentedViewController
    }
    return topMostViewController
  }
}

