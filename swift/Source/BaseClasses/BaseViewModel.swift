//
//  BaseViewModel.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class BaseViewModel<T> {

    public let dependencies: DependencyProvider
    public var elements: Driver<[T]>?
    public let loadError: Driver<Error>
    public let indicatorViewAnimating: Driver<Bool>
    public let loadAction: Action<T, T>
    
    public var transferDataValue: TransferType = ""

    public let backPressed = PublishSubject<Void>()
    public var present = ReplaySubject<(PresentScene)>.create(bufferSize: 1)
    
    public let disposeBag = DisposeBag()
    
    init(dependencies: DependencyProvider) {
        self.dependencies = dependencies
        loadAction = Action { .just($0) }
        indicatorViewAnimating = loadAction.executing.asDriver(onErrorJustReturn: false)
        loadError = loadAction.errors.asDriver(onErrorDriveWith: .empty())
            .flatMap { error -> Driver<Error> in
                switch error {
                case .underlyingError(let error):
                    return Driver.just(error)
                case .notEnabled:
                    return Driver.empty()
                }
        }
        performAction()
    }
    internal func performAction() {}
}
