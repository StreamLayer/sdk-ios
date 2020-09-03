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
import RealmSwift

class BaseViewModel<T> {

    public let dependencies: Dependency
    public var elements: Driver<[T]>?
    public let loadError: Driver<Error>
    public let indicatorViewAnimating: Driver<Bool>
    public let loadAction: Action<T, T>
    
    public let disposeBag = DisposeBag()
    
    init(dependencies: Dependency) {
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
