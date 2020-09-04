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
       return WatchSceneViewController.instantiate(with: WatchSceneViewModel(dependencies: dependency))
   }
}
