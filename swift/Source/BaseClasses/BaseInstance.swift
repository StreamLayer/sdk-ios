//
//  BaseInstance.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import UIKit

typealias ViewModelItem = BaseViewModel<Any>

protocol ViewModelBased: class {
  associatedtype ViewModel
  var viewModel: ViewModel? { get set }
}

// MARK: - Controller initiate

public protocol BaseInstance: class {}

public extension BaseInstance where Self: UIViewController {
  static func instance() -> Self {
    return Self()
  }
}

extension BaseInstance where Self: UIViewController & ViewModelBased {
  static func instantiate(with viewModel: ViewModel) -> Self {
    let viewController = Self.instance()
    viewController.viewModel = viewModel
    return viewController
  }
}
