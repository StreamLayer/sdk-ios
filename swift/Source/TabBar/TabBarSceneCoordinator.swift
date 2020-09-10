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
    let viewModel = TabBarSceneViewModel(dependency: dependency)
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
      .map {  coordinate(to: $0.coordinator(window: window, dependency: dependency)) }
  }
}

extension TabBarSceneModel {
  
  func coordinator(window: UIWindow,
                   dependency: DependencyProvider) -> BaseCoordinator<UINavigationController> {
    switch self {
    case .home:
      let coordinator = HomeSceneCoordinator(window: window, dependency: dependency)
      coordinator.tabBarIcon = Asset.Images.home.image
      coordinator.title = L10n.home
      return coordinator
    case .scores:
      let coordinator = ScoresSceneCoordinator(window: window, dependency: dependency)
      coordinator.tabBarIcon = Asset.Images.score.image
      coordinator.title = L10n.scores
      return coordinator
    case .watch:
      let coordinator = WatchSceneCoordinator(window: window, dependency: dependency)
      coordinator.tabBarIcon = Asset.Images.watch.image
      coordinator.title = L10n.watch
      return coordinator
    case .espn:
      let coordinator = ESPNSceneCoordinator(window: window, dependency: dependency)
      coordinator.tabBarIcon = Asset.Images.espn.image
      coordinator.title = L10n.espn
      return coordinator
    case .more:
      let coordinator = MoreSceneCoordinator(window: window, dependency: dependency)
      coordinator.tabBarIcon = Asset.Images.more.image
      coordinator.title = L10n.more
      return coordinator
    }
  }
}
