//
//  BaseViewController.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import UIKit
import RxSwift
import RxCocoa
import Foundation

class BaseViewController<T>: UIViewController, ViewModelBased, BaseInstance {
  
  typealias ViewModel = T
  var viewModel: T?
  
  var screenName: String = ""
  internal let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    screenName = NSStringFromClass(type(of: self))
    print("\(screenName) create")
    setupUI()
    setupBindings()
    
    if !whenLoadedBlocks.isEmpty {
      whenLoadedBlocks.forEach({ $0() })
      whenLoadedBlocks.removeAll()
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  deinit {
    print("\(NSStringFromClass(type(of: self))) deinit")
  }
  
  private var whenLoadedBlocks = [(() -> Void)]()
  
  func whenLoaded(block: @escaping (() -> Void)) {
    if isViewLoaded {
      block()
    } else {
      whenLoadedBlocks.append(block)
    }
  }
  
  internal func setupUI() {}
  
  internal func setupBindings() {}
}

class BaseTabBarController<C>: BaseSceneCoordinator<UINavigationController> {
  public var tabBarIcon: UIImage?
  
  func controller() -> BaseViewController<C> {
    return BaseViewController<C>()
  }
  
  override func start() -> Observable<UINavigationController> {
    let navigationController = UINavigationController(rootViewController: controller())
    navigationController.isNavigationBarHidden = true
    navigationController.tabBarItem.image = tabBarIcon
    
    return Observable<UINavigationController>.just(navigationController)
  }
}

protocol CellIdentifierable {
    static var identifier: String { get }
}

extension CellIdentifierable where Self: UIView {
    static var identifier: String {
        return NSStringFromClass(Self.self)
    }
}
