//
//  GameScene.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/11/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let background = SKSpriteNode(imageNamed:"background.png")
    let gameBottom = SKSpriteNode(imageNamed: "Bottom_Map.png")
    let gameTop = SKSpriteNode(imageNamed: "Top_Map.png")
    
    let player = Player()
    
   var isMoving = Bool(false)
    
    override func didMove(to view: SKView) {
        initGame()
        view.showsPhysics = true
        gameTop.setScale(CGFloat(1.25))
        gameBottom.setScale(CGFloat(1.25))
        
        player.scale(to: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: -size.width/2, y: 0)
        
        //physicsWorld.contactDelegate = self
        
        gameTop.position = CGPoint(x: -size.width/2 + gameTop.size.width/2, y: size.height/2 - gameTop.size.height/2 )
        gameBottom.position = CGPoint(x: -size.width/2 + gameBottom.size.width/2, y : -size.height/2 + gameBottom.size.height/2)
        
        gameTop.physicsBody = SKPhysicsBody(texture: gameTop.texture!, size: gameTop.size)
        gameTop.physicsBody?.affectedByGravity = false
        gameTop.physicsBody?.isDynamic = false
        gameTop.physicsBody?.restitution = CGFloat(0)
        gameTop.physicsBody?.usesPreciseCollisionDetection = true
        
        
        gameBottom.physicsBody = SKPhysicsBody(texture: gameBottom.texture!, size: gameBottom.size)
        gameBottom.physicsBody?.affectedByGravity = false
        gameBottom.physicsBody?.isDynamic = false
        gameBottom.physicsBody?.restitution = CGFloat(0)
        gameBottom.physicsBody?.usesPreciseCollisionDetection = true
        
        player.physicsBody = SKPhysicsBody(texture: player.texture!, size: player.size)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.restitution = CGFloat(0)
        player.physicsBody?.usesPreciseCollisionDetection = true
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        background.zPosition = -1
        
        addChild(background)
        addChild(gameBottom)
        addChild(gameTop)
        addChild(player)
    }
    
    private func initGame() {
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if (gameTop.position.x + gameTop.size.width/2 > size.width/2) {
        gameTop.position = CGPoint(x: gameTop.position.x - 3, y: gameTop.position.y )
        gameBottom.position = CGPoint(x: gameBottom.position.x - 3, y : gameBottom.position.y)
        } 
        player.handleGravity(_gravity: physicsWorld.gravity.dy)
        player.update()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
           if (touch.location(in: self).x < 0) {
            physicsWorld.gravity.dy = -physicsWorld.gravity.dy
            }
            
            player.handleTouchesBegin(_position: touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        player.handleTouchesEnd()
    }
}
