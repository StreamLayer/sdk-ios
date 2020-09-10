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
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  func setup(_ item: WatchStream) {
    addSubview(imageView)
    imageView.snp.makeConstraints({
      $0.edges.equalToSuperview()
    })
    imageView.image = item.image
    layer.cornerRadius = 15
    clipsToBounds = true
  }
}
