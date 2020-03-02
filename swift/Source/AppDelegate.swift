//
//  AppDelegate.swift
//

import UIKit
import UserNotifications

import StreamLayer
import StreamLayerVendor

/// SDK key can be created in the StreamLayer admin panel. Check the official documentation for the relevant link.
let sdkKey = "29d0c798269575c4335f06a4a38318002e20029c5301f38e222874fa66e712b3"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication .LaunchOptionsKey: Any]?) -> Bool {
    
    initiateStreamLayer()

    window = UIWindow()
    window?.makeKeyAndVisible()
    window?.rootViewController = ViewController()

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

extension AppDelegate {
  func initiateStreamLayer() {
    do {
      try StreamLayer.initSDK(with: sdkKey)
    } catch {
      fatalError("failed to init StreamLayer SDK: \(error)")
    }
  }
}
