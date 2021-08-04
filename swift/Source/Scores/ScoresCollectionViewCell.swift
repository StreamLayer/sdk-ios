//
//  ScoresCollectionViewCell.swift
//  Demo
//
//  Created by Yuriy Granchenko on 08.09.2020.
//
import UIKit
import Foundation

class ScoresCollectionViewCell: UICollectionViewCell, CellIdentifierable {
    private let imageView: UIImageView = {
    let imageView = UIImageView()
    return imageView
  }()
  
  func setup(_ image: UIImage) {
    layer.cornerRadius = 15
    layer.masksToBounds = true
    addSubview(imageView)
    imageView.snp.makeConstraints({
      $0.edges.equalToSuperview()
    })
    imageView.image = image
  }
}