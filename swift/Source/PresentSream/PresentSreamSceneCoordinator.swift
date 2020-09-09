//  
//  PresentSreamSceneCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 09.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class PresentSreamSceneCoordinator: BaseSceneCoordinator<TransferDataType> {
    
    override func start() -> Observable<TransferDataType> {
        let viewModel = PresentSreamSceneViewModel(dependency: dependency)
        let viewController = PresentSreamSceneViewController.instantiate(with: viewModel)
        let navigationController = window.rootViewController as? UINavigationController
        navigationController?.pushViewController(viewController, animated: false)
        viewModel.present.subscribe(onNext: { [unowned self] scene in
            self.presentCoordinator(scene.rawValue)
        }).disposed(by: disposeBag)
        return Observable.just(.empty)
    }
}
