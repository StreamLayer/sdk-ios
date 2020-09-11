//  
//  MoreSceneViewController.swift
//  Demo
//
//  Created by Yuriy Granchenko on 08.09.2020.
//

import UIKit
import RxSwift
import RxCocoa

class MoreSceneViewController: BaseViewController<MoreSceneViewModel> {
    
    let navigationBarView = NavigationBarView {
      let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = L10n.more
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 22.0, weight: .semibold)
        return titleLabel
      }()
      return titleLabel
    }
    
    let bodyImageView: UIImageView = {
      let imageView = UIImageView()
      imageView.image = Asset.Images.moreBody.image
      return imageView
    }()
    
    override func setupUI() {
      view.addSubview(navigationBarView)
      view.addSubview(bodyImageView)
      navigationBarView.snp.makeConstraints({
        $0.leading.top.trailing.equalToSuperview()
        $0.height.equalTo(88)
      })
      bodyImageView.snp.makeConstraints({ [weak navigationBarView] in
        guard let navigationBarView = navigationBarView else { return }
        $0.top.equalTo(navigationBarView.snp.bottom)
        $0.leading.trailing.bottom.equalToSuperview()
      })
    }
    
    override func setupBindings() {
//        viewModel?.indicatorViewAnimating.drive(<#drive#>),
//        viewModel?.elements.drive(<#drive#>),
//        viewModel?.loadError.drive(onNext: {<#drive#>}),
    }
}
