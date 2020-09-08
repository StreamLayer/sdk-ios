//  
//  MoreSceneCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 08.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class MoreSceneCoordinator: BaseTabBarCoordinator<MoreSceneViewModel> {
    
  override func controller() -> BaseViewController<MoreSceneViewModel> {
    return MoreSceneViewController.instantiate(with: MoreSceneViewModel(dependency: dependency))
  }
}
