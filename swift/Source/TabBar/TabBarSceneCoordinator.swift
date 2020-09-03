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
    viewModel.present.subscribe(onNext: { [unowned self] scene in
      self.presentCoordinator(scene.rawValue)
    }).disposed(by: disposeBag)
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    return Observable.just(.empty)
  }
}

extension TabBarSceneCoordinator {
    public func configure() -> [Observable<TransferDataType>] {
        return TabBarSceneModel.allCases
            .map {  coordinate(to: $0.coordinator(window: window, dependencies: dependency)) }
    }
}

extension TabBarSceneModel {
    
    func coordinator(window: UIWindow, dependencies: DependencyProvider) -> BaseSceneCoordinator<TransferDataType> {
           switch self {
           case .home:
               let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
//               coordinator.tabBarIcon = UIImage(systemName: rawValue)
               return coordinator
           case .scores:
                let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
               //               coordinator.tabBarIcon = UIImage(systemName: rawValue)
                              return coordinator
           case .watch:
                let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
               //               coordinator.tabBarIcon = UIImage(systemName: rawValue)
                              return coordinator
           case .espn:
                let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
               //               coordinator.tabBarIcon = UIImage(systemName: rawValue)
                              return coordinator
           case .more:
               let coordinator = WatchSceneCoordinator(window: window, dependency: dependencies)
               //               coordinator.tabBarIcon = UIImage(systemName: rawValue)
                              return coordinator
           }
       }
}
