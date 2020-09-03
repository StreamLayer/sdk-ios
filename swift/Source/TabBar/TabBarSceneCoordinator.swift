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
