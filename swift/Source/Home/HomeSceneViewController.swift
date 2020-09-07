//  
//  HomeSceneViewController.swift
//  Demo
//
//  Created by Yuriy Granchenko on 04.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class HomeSceneViewController: BaseViewController<HomeSceneViewModel> {
  let navigationBarView = NavigationBarView()
  
  override func setupUI() {
    view.backgroundColor = .white
    view.addSubview(navigationBarView)
    navigationBarView.snp.makeConstraints({
      $0.leading.top.trailing.equalToSuperview()
      $0.height.equalTo(88)
    })
  }
  
  override func setupBindings() {
    //        viewModel?.indicatorViewAnimating.drive(<#drive#>),
    //        viewModel?.elements.drive(<#drive#>),
    //        viewModel?.loadError.drive(onNext: {<#drive#>}),
  }
}
