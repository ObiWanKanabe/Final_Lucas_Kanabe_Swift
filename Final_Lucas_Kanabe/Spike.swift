//
//  Spike.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/23/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import Foundation
import SpriteKit

class Spike: GameObject {
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture.init(imageNamed: "spike.png")
        
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width * 1.75, height: texture.size().height * 1.75))
        
        initialize()
    
    }
    
    // Initialization here
    override func initialize() {
        name = "Spike"
        
        physicsBody = SKPhysicsBody(rectangleOf: texture!.size())
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = false
        physicsBody?.restitution = CGFloat(0)
        physicsBody?.usesPreciseCollisionDetection = true
        
        // Setting category bit mask so player is 
        physicsBody?.categoryBitMask = 2
        physicsBody?.contactTestBitMask = 0
    }
    
    // Update is called every frame
    override func update() {
        // Scroll the spikes with the map
        if (!isLevelDoneScrolling) {
            position = CGPoint(x: position.x - 3, y: position.y)
        }
    }
    
    // Flips the spike upside down
    func setFlipped() {
        scale(to: CGSize(width: 7 * 1.75, height: -8 * 1.75))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

