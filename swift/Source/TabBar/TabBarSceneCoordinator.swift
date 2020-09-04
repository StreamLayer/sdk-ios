//  
//  TabBarSceneCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class TabBarSceneCoordinator: BaseSceneCoordinator<TransferDataType> {
  
  override func start() -> Observable<TransferDataType> {
    let viewModel = TabBarSceneViewModel(dependencies: dependency)
    let viewController = TabBarSceneViewController.instantiate(with: viewModel)
    let rootViewController = UINavigationController(rootViewController: viewController)
    rootViewController.isNavigationBarHidden = true
    Observable.combineLatest(configure())
      .subscribe(onNext: { viewControllers in
        viewController.viewControllers = viewControllers
      }).disposed(by: disposeBag)
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    return Observable.just(.empty)
  }
}

extension TabBarSceneCoordinator {
  public func configure() -> [Observable<UINavigationController>] {
    return TabBarSceneModel.allCases
      .map {  coordinate(to: $0.coordinator(window: window, dependencies: dependency)) }
  }
}

extension TabBarSceneModel {
  
  func coordinator(window: UIWindow,
                   dependencies: DependencyProvider) -> BaseCoordinator<UINavigationController> {
    switch self {
    case .home:
      let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
      coordinator.tabBarIcon = Asset.Images.home.image
      return coordinator
    case .scores:
      let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
      coordinator.tabBarIcon = Asset.Images.score.image
      return coordinator
    case .watch:
      let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
      coordinator.tabBarIcon = Asset.Images.watch.image
      return coordinator
    case .espn:
      let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
      coordinator.tabBarIcon = Asset.Images.espn.image
      return coordinator
    case .more:
      let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
      coordinator.tabBarIcon = Asset.Images.more.image
      return coordinator
    }
  }
}
