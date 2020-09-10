//  
//  WatchSceneCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class WatchSceneCoordinator: BaseTabBarCoordinator<WatchSceneViewModel> {
    
  override func controller() -> BaseViewController<WatchSceneViewModel> {
    let viewModel = WatchSceneViewModel(dependency: dependency)
//    viewModel.present.subscribe(onNext: { [weak self] scene in
//      self?.presentCoordinator(<#T##coordinator: BaseSceneCoordinator<UINavigationController>##BaseSceneCoordinator<UINavigationController>#>)
//    }).disposed(by: disposeBag)
    return WatchSceneViewController.instantiate(with: viewModel)
  }
}
