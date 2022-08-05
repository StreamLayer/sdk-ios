//
//  AppDelegate.swift
//

import UIKit
import UserNotifications
import StreamLayer
import StreamLayerVendor
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
    StreamLayer.initSDK(with: key)
    StreamLayer.config = StreamLayerSilentModeConfig()
    StreamLayer.config.phoneContactsSyncEnabled = false
    StreamLayer.config.shouldIncludeTopGestureZone = true
    StreamLayer.config.isUserProfileOverlayHidden = true
    StreamLayer.config.notificationsMode = [.vote, .promotion, .twitter]
  }
}
