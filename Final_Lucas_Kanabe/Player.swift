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
    case STILL
    case FOLLOWING
    case MOVING
}

class Player: GameObject {
    
    let spriteFlipUp = SKAction.scale(to: CGSize(width: 40, height: -50), duration: 0.3)
    let spriteFlipDown = SKAction.scale(to: CGSize(width: 40, height: 50), duration: 0.3)
    
    var movement = MovementState.FOLLOWING
    
    var idleTextures: [SKTexture] = []
    var moveTextures: [SKTexture] = []
    
    var idleAnimation : Animation = Animation()
    var moveAnimation : Animation = Animation()
    var runAnimation : Animation = Animation()
    
    var isLevelDone : Bool = Bool(false)
    
    var screenBoundRight = CGFloat()
    var screenBoundLeft = CGFloat()
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture.init(imageNamed: "stickMan1white.png")
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width / 4, height: texture.size().height / 4))
        
        initialize()
    }
    
    override func initialize() {
        
        name = "Player"
        idleTextures = [SKTexture(imageNamed: "stickManIdle1white.png"),
                        SKTexture(imageNamed: "stickManIdle2white.png")]
    
        moveTextures = [SKTexture(imageNamed: "stickMan1white.png"),
                        SKTexture(imageNamed: "stickMan2white.png"),
                        SKTexture(imageNamed: "stickMan3white.png"),
                        SKTexture(imageNamed: "stickMan4white.png"),]
        
        idleAnimation = Animation(textures: idleTextures, frameTime: 0.5)
        moveAnimation = Animation(textures: moveTextures, frameTime: 0.25)
        runAnimation = Animation(textures: moveTextures, frameTime: 0.15)
        
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = CGFloat(0)
        physicsBody?.usesPreciseCollisionDetection = true
        
        self.run(moveAnimation.getRepeatedAction())
    }
    
    override func update() {
        if (movement == MovementState.MOVING) {
            physicsBody?.velocity.dx = CGFloat(100)
        } else if (movement == MovementState.FOLLOWING){
            physicsBody?.velocity.dx = CGFloat(0)
        } else if (movement == MovementState.STILL) {
        }
        
        if (physicsBody?.velocity.dx == CGFloat(0) && isLevelDone) {
            setStill()
        }
        
        if (position.x >= screenBoundRight - size.width/2 && !isLevelDone) {
            position.x = screenBoundRight - size.width/2
        }
        
    }
    
    func setScreenbounds(_leftX: CGFloat, _rightX: CGFloat) {
        screenBoundLeft = _leftX
        screenBoundRight = _rightX
    }
    
    func setMoving() {
        movement = MovementState.MOVING
        physicsBody?.velocity.dx = CGFloat(100)
        self.run(runAnimation.getRepeatedAction())
    }
    
    func setFollowing() {
        movement = MovementState.FOLLOWING
        physicsBody?.velocity.dx = CGFloat(0)
        self.run(moveAnimation.getRepeatedAction())
    }
    
    func setStill() {
        movement = MovementState.STILL
        self.run(idleAnimation.getRepeatedAction())
    }
    
    func setLevelEnd() {
        isLevelDone = true
    }
    
    func handleTouchesBegin (_position: CGPoint) {
        if (_position.x > 0) {
            setMoving()
        }
    }
    
    func handleTouchesEnd () {
        setFollowing()
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
