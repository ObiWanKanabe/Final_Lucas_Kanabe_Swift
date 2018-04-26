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

// Enum to control animations of the player
enum MovementState {
    case STILL
    case FOLLOWING
    case MOVING
}

class Player: GameObject {
    
    // Gravity change flips
    let spriteFlipUp = SKAction.scale(to: CGSize(width: 40, height: -50), duration: 0.3)
    let spriteFlipDown = SKAction.scale(to: CGSize(width: 40, height: 50), duration: 0.3)
    
    // Player is following the map scroll by default
    var movement = MovementState.FOLLOWING
    
    // The textures of the idle and movement animations
    var idleTextures: [SKTexture] = []
    var moveTextures: [SKTexture] = []
    
    // The 3 animation struct types
    private var idleAnimation : Animation = Animation()
    private var moveAnimation : Animation = Animation()
    private var runAnimation : Animation = Animation()
    
    // The screen bounds so the player does not go off screen
    private var screenBoundRight = CGFloat()
    private var screenBoundLeft = CGFloat()
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture.init(imageNamed: "stickMan1white.png")
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width / 4, height: texture.size().height / 4))
        
        initialize()
    }
    
    // Initialization here
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
        runAnimation = Animation(textures: moveTextures, frameTime: 0.10)
        
        physicsBody = SKPhysicsBody(texture: texture!, size: size)
        physicsBody?.allowsRotation = false
        physicsBody?.restitution = CGFloat(0)
        physicsBody?.usesPreciseCollisionDetection = true
        
        physicsBody?.categoryBitMask = 0
        // Setting contact bit mask to be notified about spike contact
        physicsBody?.contactTestBitMask = 2
        
        self.run(moveAnimation.getRepeatedAction())
    }
    
    // Update is called every frame
    override func update() {
        // Force the physics body velocity on movement and following
        if (movement == MovementState.MOVING) {
            physicsBody?.velocity.dx = CGFloat(100)
        } else if (movement == MovementState.FOLLOWING){
            physicsBody?.velocity.dx = CGFloat(0)
        }
        
        // One level is done, set the player still
        if (physicsBody?.velocity.dx == CGFloat(0) && isLevelDoneScrolling) {
            setStill()
        }
        
        // Force player inside screen bounds while level is still scrolling
        if (position.x >= screenBoundRight - size.width/2 && !isLevelDoneScrolling) {
            position.x = screenBoundRight - size.width/2
        }
        
    }
    
    // Store the screen bounds
    func setScreenbounds(_leftX: CGFloat, _rightX: CGFloat) {
        screenBoundLeft = _leftX
        screenBoundRight = _rightX
    }
    
    // State setters
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
    
    // Handle touch begin
    func handleTouchesBegin (_position: CGPoint) {
        // If right side of sreen is pressed, Player is moving
        if (_position.x > 0) {
            setMoving()
        }
    }
    
    // Handle touch end
    func handleTouchesEnd () {
        // Once nothing is pressed, Player is following
        setFollowing()
    }
    
    // Flip the sprite dependent on gravity
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
