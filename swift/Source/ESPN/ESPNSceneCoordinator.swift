//  
//  ESPNSceneCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 10.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class ESPNSceneCoordinator: BaseTabBarCoordinator<ESPNSceneViewModel> {
  
override func controller() -> BaseViewController<ESPNSceneViewModel> {
  return ESPNSceneViewController.instantiate(with: ESPNSceneViewModel(dependency: dependency))
}
}
