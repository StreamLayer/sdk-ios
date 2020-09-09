//  
//  PresentSreamSceneModel.swift
//  Demo
//
//  Created by Yuriy Granchenko on 09.09.2020.
//

import UIKit
import RealmSwift

final class PresentSreamSceneModel: Object {
    
    @objc dynamic public var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
