//
//  AppDelegate.swift
//

import UIKit
import UserNotifications
import StreamLayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, SLROverlayDelegate {

  func requestAudioDucking() {

  }

  func disableAudioDucking() {

  }

  func prepareAudioSession(for type: SLRAudioSessionType) {

  }

  func disableAudioSession(for type: SLRAudioSessionType) {

  }

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication .LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow()
    window?.makeKeyAndVisible()
    window?.rootViewController = StreamLayer.createOverlay(UIView(), overlayDelegate: self, sdkKey: "key")

    return true
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

  }

  func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    debugPrint("Push Notifications: Failed to register for remote notifications with error: \(error)")
  }

  func applicationWillResignActive(_ application: UIApplication) {

  }

  func applicationDidEnterBackground(_ application: UIApplication) {

  }

  func applicationWillEnterForeground(_ application: UIApplication) {

  }

  func applicationDidBecomeActive(_ application: UIApplication) {

  }

  func applicationWillTerminate(_ application: UIApplication) {

  }
}
