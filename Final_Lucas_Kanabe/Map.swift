//
//  Map.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/24/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Map : GameObject {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: .clear, size: CGSize(width: (texture?.size().width)! * 1.25, height: (texture?.size().height)! * 1.25))
        
        initialize()
    }
    
    // Initialization here
    override func initialize() {
        
        name = "Map"
        
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.restitution = CGFloat(0)
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.categoryBitMask = 1
        
    }
    
    // Update is called every frame
    override func update(_currentTime: TimeInterval) {
        super.update(_currentTime: _currentTime)
        // Scroll the map
        if (!isLevelDoneScrolling) {
        position = CGPoint(x: position.x - CGFloat(100 * deltaTime), y: position.y)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
