//
//  Player.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/23/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

enum MovementState {
    case still
    case moving
}

class Player: SKSpriteNode {
    
    
    let spriteFlipUp = SKAction.scale(to: CGSize(width: 50, height: -50), duration: 0.3)
    let spriteFlipDown = SKAction.scale(to: CGSize(width: 50, height: 50), duration: 0.3)
    
    var movement = MovementState.still
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture.init(imageNamed: "megaman.png")
        
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width / 4, height: texture.size().height / 4))
        
        name = "Player"
        
        physicsBody = SKPhysicsBody(texture: texture, size: size)
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = CGFloat(0)
        physicsBody?.usesPreciseCollisionDetection = true

    }
    
    func update() {
        if (movement == MovementState.moving) {
            physicsBody?.velocity.dx = CGFloat(100)
        } else if (movement == MovementState.still){
            physicsBody?.velocity.dx = CGFloat(0)
        }
    }
    
    func handleTouchesBegin (_position: CGPoint) {
        if (_position.x > 0) {
            movement = MovementState.moving
        }
    }
    
    func handleTouchesEnd () {
        movement = MovementState.still
    }
    
    func handleGravity (_gravity: CGFloat) {
        if (_gravity > 0) {
            run(spriteFlipUp)
        } else {
            run(spriteFlipDown)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
