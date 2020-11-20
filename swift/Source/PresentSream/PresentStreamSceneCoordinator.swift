//  
//  PresentStreamSceneCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 09.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class PresentStreamSceneCoordinator: BaseSceneCoordinator<TransferDataType> {
    
    override func start() -> Observable<TransferDataType> {
        let viewModel = PresentStreamSceneViewModel(dependency: dependency)
        let viewController = PresentStreamSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: true)
        viewModel.present.subscribe(onNext: { [unowned self] scene in
            self.presentCoordinator(scene.rawValue)
        }).disposed(by: disposeBag)
        return Observable.just(.empty)
    }
}
