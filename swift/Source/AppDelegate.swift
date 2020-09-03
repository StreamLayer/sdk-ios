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
let sdkKey = "16ab1e23f2a8682d3c176c611c4ee2c1afaa962ee20b6f451b4293cd5a67bf5a"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  fileprivate let window = UIWindow()
  fileprivate var appCoordinator: AppCoordinator?
  fileprivate let disposeBag = RxSwift.DisposeBag()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication .LaunchOptionsKey: Any]?) -> Bool {
    
    initiateStreamLayer()
    
    let dependency = Dependency(authService: AuthService())
    appCoordinator = AppCoordinator(window: window, dependency: dependency)
    appCoordinator?.start().subscribe().disposed(by: disposeBag)

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
    // INFO: setup for demo events date
    UserDefaults.standard.set("2019-11-26", forKey: "EventsDemoDate")
    StreamLayer.initSDK(with: sdkKey, isDebug: true, loggerDelegate: self)
  }
}

extension AppDelegate: SLROverlayLoggerDelegate {
  func sendLogdata(userInfo: String) {
    print("log: \(userInfo)")
  }
}
