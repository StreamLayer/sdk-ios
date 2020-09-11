//
//  NavigationBarView.swift
//  Demo
//
//  Created by Yuriy Granchenko on 07.09.2020.
//
import UIKit
import Foundation

class NavigationBarView: UIView {
  
  let searchImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = Asset.Images.search.image
    return imageView
  }()
  
  let settingsImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = Asset.Images.settings.image
    return imageView
  }()
  
  let groupImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = Asset.Images.group.image
    return imageView
  }()
  
  convenience init(with title: () -> (UIView)) {
    self.init(frame: .zero)
    let titleView = title()
    addSubview(titleView)
    titleView.snp.makeConstraints({
      $0.bottom.equalToSuperview().inset(20)
      $0.centerX.equalToSuperview()
    })
    setup(titleView)
  }
  
  func setup (_ titleView: UIView) {
    backgroundColor = .black
    addSubview(searchImageView)
    addSubview(settingsImageView)
    addSubview(groupImageView)
    searchImageView.snp.makeConstraints({ [weak titleView] in
      guard let titleView = titleView else { return }
      $0.bottom.equalTo(titleView)
      $0.leading.equalToSuperview().offset(20)
    })
    settingsImageView.snp.makeConstraints({ [weak titleView] in
      guard let titleView = titleView else { return }
      $0.bottom.equalTo(titleView)
      $0.trailing.equalToSuperview().inset(20)
    })
    groupImageView.snp.makeConstraints({[weak settingsImageView] in
      guard let settingsImageView = settingsImageView else { return }
      $0.bottom.equalTo(titleView)
      $0.trailing.equalTo(settingsImageView.snp.leading).inset(-10)
    })
  }
}
