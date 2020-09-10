//
//  WatchStreamCell.swift
//  Demo
//
//  Created by Yuriy Granchenko on 09.09.2020.
//
import UIKit
import Foundation

class WatchStreamCell: UICollectionViewCell, CellIdentifierable {
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  func setup(_ item: WatchStream) {
    layer.cornerRadius = 15
    layer.masksToBounds = true
    addSubview(imageView)
    imageView.snp.makeConstraints({
      $0.edges.equalToSuperview()
    })
    imageView.image = item.image
  }
  
}
