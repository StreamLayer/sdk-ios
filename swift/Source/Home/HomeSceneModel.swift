//  
//  HomeSceneModel.swift
//  Demo
//
//  Created by Yuriy Granchenko on 04.09.2020.
//

import UIKit

enum HomeSceneModel: CaseIterable {
  case top, middle, bottom
  
  var image: UIImage {
    switch self {
    case .top:
      return Asset.Images.top.image
      case .middle:
      return Asset.Images.middle.image
      case .bottom:
      return Asset.Images.bottom.image
    }
  }
}
