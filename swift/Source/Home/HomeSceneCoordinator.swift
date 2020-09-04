//  
//  HomeSceneCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 04.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class HomeSceneCoordinator: BaseTabBarCoordinator<HomeSceneViewModel> {
    
  override func controller() -> BaseViewController<HomeSceneViewModel> {
    return HomeSceneViewController.instantiate(with: HomeSceneViewModel(dependency: dependency))
  }
}
