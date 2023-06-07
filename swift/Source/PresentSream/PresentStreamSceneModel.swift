//  
//  PresentStreamSceneModel.swift
//  Demo
//
//  Created by Yuriy Granchenko on 09.09.2020.
//

import UIKit

final class PresentStreamSceneModel: NSObject {
    
    @objc dynamic public var id = 0
    
    static func primaryKey() -> String? {
        return "id"
    }
}
