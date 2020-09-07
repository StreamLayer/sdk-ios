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
  
  let espnLogoImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = Asset.Images.espnLogo.image
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
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setup()
  }
  
  func setup () {
    backgroundColor = .black
    addSubview(searchImageView)
    addSubview(espnLogoImageView)
    addSubview(settingsImageView)
    addSubview(groupImageView)
    searchImageView.snp.makeConstraints({
      $0.bottom.equalToSuperview().inset(20)
      $0.leading.equalToSuperview().offset(20)
    })
    espnLogoImageView.snp.makeConstraints({
      $0.bottom.equalTo(searchImageView)
      $0.centerX.equalToSuperview()
    })
    settingsImageView.snp.makeConstraints({
      $0.bottom.equalTo(searchImageView)
      $0.trailing.equalToSuperview().inset(20)
    })
    groupImageView.snp.makeConstraints({
      $0.bottom.equalTo(searchImageView)
      $0.trailing.equalTo(settingsImageView.snp.leading).inset(-10)
    })
  }
}
