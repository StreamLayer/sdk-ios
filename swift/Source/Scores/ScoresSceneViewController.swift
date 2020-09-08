//  
//  ScoresSceneViewController.swift
//  Demo
//
//  Created by Yuriy Granchenko on 04.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class ScoresSceneViewController: BaseViewController<ScoresSceneViewModel> {
  let navigationBarView = NavigationBarView {
    let titleLabel: UILabel = {
      let titleLabel = UILabel()
      titleLabel.text = L10n.scores
      titleLabel.textColor = .white
      titleLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
      return titleLabel
    }()
    return titleLabel
  }
  
  override func setupUI() {
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
