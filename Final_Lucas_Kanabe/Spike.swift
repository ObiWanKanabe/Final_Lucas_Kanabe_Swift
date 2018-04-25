//
//  Spike.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/23/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import SpriteKit
import Foundation

class Spike: GameObject {
    
    var isLevelDone : Bool = Bool(false)
    
    override func initialize() {
         name = "Spike"
    }
    
    override func update() {
        if (!isLevelDone) {
            position = CGPoint(x: position.x - 3, y: position.y)
        }
    }
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture.init(imageNamed: "spike.png")
        
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width * 1.75, height: texture.size().height * 1.75))
        initialize()
        
        physicsBody = SKPhysicsBody(rectangleOf: texture.size())
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.restitution = CGFloat(0)
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.categoryBitMask = 2
        physicsBody?.contactTestBitMask = 0
        
    }
    
    func setFlipped() {
        scale(to: CGSize(width: 7 * 1.75, height: -8 * 1.75))
    }
    
    func setLevelEnd() {
        isLevelDone = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

