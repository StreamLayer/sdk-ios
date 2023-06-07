//
//  AppDelegate.swift
//

import UIKit
import UserNotifications
import StreamLayer
import RxSwift

/// SDK key can be created in the StreamLayer admin panel. Check the official documentation for the relevant link.
/// You MUST use your own key.
let sdkKey = "sdkKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
  
  fileprivate let window = UIWindow()
  fileprivate var appCoordinator: AppCoordinator?
  fileprivate let disposeBag = RxSwift.DisposeBag()
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions
    launchOptions: [UIApplication .LaunchOptionsKey: Any]?) -> Bool {
    
    UITabBar.appearance().tintColor = .black
    
    initiateStreamLayer(launchOptions: launchOptions)
    
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
  
  // MARK: App Links
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
    return StreamLayer.processDeepLink(app, url, options)
  }

  // MARK: Universal Links
  func application(_ application: UIApplication,
                   continue userActivity: NSUserActivity,
                   restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
    return StreamLayer.processUniversalLink(continue: userActivity)
  }
}

extension AppDelegate {
  func initiateStreamLayer(launchOptions: [UIApplication .LaunchOptionsKey: Any]? = nil) {
    let key = Bundle.main.object(forInfoDictionaryKey: sdkKey) as? String ?? ""
    StreamLayer.initSDK(with: key, isDebug: false, delegate: self, loggerDelegate: self)
    StreamLayer.initiateLinksHandler(launchOptions: launchOptions)
  }
}

extension AppDelegate: SLROverlayLoggerDelegate {
  func sendLogdata(userInfo: String) {
    print("log: \(userInfo)")
  }
}

extension AppDelegate {
  func application(_ application: UIApplication,
                   supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    guard let tabBarController = (window?.rootViewController as? UINavigationController)?.topViewController as? TabBarSceneViewController<TabBarSceneViewModel>,
   let topViewController = tabBarController.viewControllers?[tabBarController.selectedIndex] as? UINavigationController,  topViewController.topViewController is WatchSceneViewController else { return [.portrait] }
      return [.portrait, .landscapeLeft, .landscapeRight]
  }
}

extension AppDelegate: StreamLayerDelegate {
  func watchPartyInviteOpened(invite: SLRInviteData, completion: @escaping (Bool) -> Void) {
    guard window.isKeyWindow else {
      completion(false)
      return
    }
    
    if let root = self.window.rootViewController as? UINavigationController,
       let _ = root.presentedViewController as? PresentStreamSceneViewController {
      completion(false)
      return
    }
    
    if let coordinator = appCoordinator {
      coordinator.presentCoordinator(PresentScene.presentStream.rawValue)
        .take(1)
        .bind(onNext: { _ in
          completion(false)
        }).disposed(by: disposeBag)
    } else {
      completion(true)
    }
    
  }
}
