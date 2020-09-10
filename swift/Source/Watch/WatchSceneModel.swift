//  
//  WatchSceneModel.swift
//  Demo
//
//  Created by Yuriy Granchenko on 03.09.2020.
//

import UIKit
import RxDataSources

let watchItems =
  WatchSceneSection(header: "",
                    items: [WatchSection(header: "Stream Now",
                                         items: [WatchStream(image: Asset.Images.top.image),
                                                 WatchStream(image: Asset.Images.middle.image),
                                                 WatchStream(image: Asset.Images.bottom.image)]),
                            WatchSection(header: "Stream Now",
                                         items: [WatchStream(image: Asset.Images.top.image),
                                                 WatchStream(image: Asset.Images.middle.image),
                                                 WatchStream(image: Asset.Images.bottom.image)])] )

struct WatchSceneSection {
  var header: String
  var items: [Item]
}

extension WatchSceneSection: SectionModelType {
    typealias Item = WatchSection
    
    init(original: WatchSceneSection, items: [Item]) {
        self = original
        self.items = items
    }
}

struct WatchSection {
    var id = UUID().uuidString
    var header: String
    var items: [Item]
}

extension WatchSection: SectionModelType {
    typealias Item = WatchStream
    
    init(original: WatchSection, items: [Item]) {
        self = original
        self.items = items
    }
}

struct WatchStream {
  let image: UIImage
}
