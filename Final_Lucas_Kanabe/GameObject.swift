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
    
    var deltaTime: TimeInterval = 0.0
    private var lastUpdateTime: TimeInterval?
    
    func update(_currentTime: TimeInterval) {
        guard let lastUpdateTime = lastUpdateTime else {
            self.lastUpdateTime = _currentTime
            return
        }
        
        deltaTime = _currentTime - lastUpdateTime
        
        self.lastUpdateTime = _currentTime
    }
    func initialize(){}
    
    func setLevelEnd(_result : Bool) {
        isLevelDoneScrolling = _result
    }
}
