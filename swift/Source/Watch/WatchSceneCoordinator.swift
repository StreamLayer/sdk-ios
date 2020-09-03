//  
//  WatchSceneCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class WatchSceneCoordinator: BaseSceneCoordinator<TransferDataType> {
    
    override func start() -> Observable<TransferDataType> {
        let viewModel = WatchSceneViewModel(dependencies: dependency)
        let viewController = WatchSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: false)
        viewModel.present.subscribe(onNext: { [unowned self] scene in
            self.presentCoordinator(scene.rawValue)
        }).disposed(by: disposeBag)
        return Observable.just(.empty)
    }
}
