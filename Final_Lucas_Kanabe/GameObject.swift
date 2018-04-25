//
//  GameObject.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/24/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class GameObject : SKSpriteNode, Object{
    
    var isLevelDoneScrolling : Bool = Bool(false)
    
    func update() {}
    func initialize(){}
    
    func setLevelEnd(_result : Bool) {
        isLevelDoneScrolling = _result
    }
}
