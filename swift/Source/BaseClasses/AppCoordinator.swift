//
//  AppCoordinator.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import Foundation
import RxSwift
import RxCocoa

class AppCoordinator: BaseSceneCoordinator<TransferDataType> {
    
    override func start() -> Observable<TransferDataType> {
        return presentCoordinator(PresentScene.tabBar.rawValue)
    }
}
