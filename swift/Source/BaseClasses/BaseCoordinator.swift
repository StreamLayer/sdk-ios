//
//  BaseCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import UIKit
import RxSwift
import Foundation

typealias TransferType = String
typealias BlockValue<ResultType> = ((ResultType) -> ())

enum TransferDataType {
  case blockValue(BlockValue<TransferType>, String?)
  case empty
}

enum PresentScene {
  case tabBar, presentStream
}

extension PresentScene: RawRepresentable {
  typealias RawValue = BaseSceneCoordinator<TransferDataType>
  
  init?(rawValue: RawValue) {
    switch rawValue {
    default: return nil
    }
  }
  
  var rawValue: RawValue {
    switch self {
    case .tabBar: return TabBarSceneCoordinator()
    case .presentStream: return PresentStreamSceneCoordinator()
    }
  }
}

open class BaseCoordinator<ResultType> {
  
  typealias CoordinationResult = ResultType
  
  public let disposeBag = DisposeBag()
  private let identifier = UUID()
  private var childCoordinators = [UUID: Any]()
  
  private func store<T>(coordinator: BaseCoordinator<T>) {
    childCoordinators[coordinator.identifier] = coordinator
  }
  
  private func free<T>(coordinator: BaseCoordinator<T>) {
    childCoordinators[coordinator.identifier] = nil
  }
  
  public func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
    store(coordinator: coordinator)
    return coordinator.start()
      .do(onNext: { [weak self] _ in self?.free(coordinator: coordinator) })
  }
  
  public func start() -> Observable<ResultType> {
    fatalError("Start method should be implemented.")
  }
}

class BaseSceneCoordinator<T>: BaseCoordinator<T> {
  
  internal var window: UIWindow!
  internal var dependency: DependencyProvider!
  
  init(window: UIWindow, dependency: DependencyProvider) {
    self.window = window
    self.dependency = dependency
  }
  
  override init() {}
  
  private func setup(window: UIWindow, dependency: DependencyProvider) {
    self.window = window
    self.dependency = dependency
  }
  
  @discardableResult func presentCoordinator(_ coordinator: BaseSceneCoordinator<T>) -> Observable<T> {
    coordinator.setup(window: window, dependency: dependency)
    return self.coordinate(to: coordinator)
  }
}

class BaseTabBarCoordinator<C>: BaseSceneCoordinator<UINavigationController> {
  public var tabBarIcon: UIImage?
  public var title: String?
  
  func controller() -> BaseViewController<C> {
    return BaseViewController<C>()
  }
  
  override func start() -> Observable<UINavigationController> {
    let navigationController = UINavigationController(rootViewController: controller())
    navigationController.isNavigationBarHidden = true
    navigationController.tabBarItem.image = tabBarIcon
    navigationController.tabBarItem.title = title
    
    return Observable<UINavigationController>.just(navigationController)
  }
}


