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
    
    // Background image
    let background = SKSpriteNode(imageNamed:"background.png")
    
    // GameObjects
    let player = Player()
    let gameTop = Map(imageNamed: "Top_Map.png")
    let gameBottom = Map(imageNamed: "Bottom_Map.png")
    
    var isMoving = Bool(false)
    
    override func didMove(to view: SKView) {
        // Init objects and properties
        initGame()
        
        // Our scene objects added here
        addChild(background)
        addChild(gameBottom)
        addChild(gameTop)
        addChild(player)
    }
    
    private func initGame() {
        // Set Player position and let it know what the screen bounds are
        player.position = CGPoint(x: -size.width/2 + 100, y: 0)
        player.setScreenbounds(_leftX: -size.width/2, _rightX: size.width/2)
        
        // Set the map halves position
        gameTop.position = CGPoint(x: -size.width/2 + gameTop.size.width/2, y: size.height/2 - gameTop.size.height/2 )
        gameBottom.position = CGPoint(x: -size.width/2 + gameBottom.size.width/2, y : -size.height/2 + gameBottom.size.height/2)
        
        // Set gravity to be a little lower but normal direction downward to start
        physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        // Make sure background is behind everything
        background.zPosition = -1
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Checking if the map has reached the end, if not then move it
        if (gameTop.position.x + gameTop.size.width/2 > size.width/2) {
        gameTop.position = CGPoint(x: gameTop.position.x - 3, y: gameTop.position.y )
        gameBottom.position = CGPoint(x: gameBottom.position.x - 3, y : gameBottom.position.y)
        }
            // If map has finished moving, let the player know
        else {
            player.setLevelEnd()
        }
        
        // Call players update
        player.update()
        
        // Pass the gravity over to the player
        player.handleGravity(_gravity: physicsWorld.gravity.dy)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            // Change scene gravity if left side of screen has been pressed
           if (touch.location(in: self).x < 0) {
            physicsWorld.gravity.dy = -physicsWorld.gravity.dy
            }
            
            // Pass touch begin locations to player
            player.handleTouchesBegin(_position: touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Pass touch end locations to player
        player.handleTouchesEnd()
    }
}
