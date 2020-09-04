//  
//  ScoresSceneCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 04.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class ScoresSceneCoordinator: BaseTabBarCoordinator<ScoresSceneViewModel> {
    
  override func controller() -> BaseViewController<ScoresSceneViewModel> {
    return ScoresSceneViewController.instantiate(with: ScoresSceneViewModel(dependency: dependency))
  }
}
