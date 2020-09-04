//  
//  TabBarSceneViewController.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class TabBarSceneViewController<T>: UITabBarController, ViewModelBased, BaseInstance {
  var viewModel: T?
  typealias ViewModel = T
}
