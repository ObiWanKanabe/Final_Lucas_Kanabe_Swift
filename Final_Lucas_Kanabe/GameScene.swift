//
//  GameScene.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/11/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Background image
    let background = SKSpriteNode(imageNamed:"background.png")
    
    // GameObjects
    let player = Player()
    let gameTop = Map(imageNamed: "Top_Map.png")
    let gameBottom = Map(imageNamed: "Bottom_Map.png")
    
    var isMoving = Bool(false)
    
    var gameObjectList : [GameObject] = []
    
     let spikes1: [Spike] = SpikeFactory.createSpikes(_position: CGPoint(x: 0, y: 0), _numberOfSpikes: 5)
    
    override func didMove(to view: SKView) {
        // Init objects and properties
        initGame()
    }
    
    // Every GameObject in our scene needs to be added to the list to call their update
    private func addGameObject(_object: GameObject) {
        gameObjectList.append(_object)
        addChild(_object)
    }
    
    private func resetPositions() {
        player.position = CGPoint(x: -size.width/2 + 100, y: 0)
        gameTop.position = CGPoint(x: -size.width/2 + gameTop.size.width/2, y: size.height/2 - gameTop.size.height/2 )
        gameBottom.position = CGPoint(x: -size.width/2 + gameBottom.size.width/2, y : -size.height/2 + gameBottom.size.height/2)
        
        for i in stride(from: 0, to: spikes1.count, by: 1) {
            spikes1[i].position = CGPoint(x:0 + i*7, y:0)
        }
    }
    
    private func initGame() {
        view?.showsPhysics = true
        physicsWorld.contactDelegate = self
        
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
    
        // Our scene objects added here
        addChild(background)
        addGameObject(_object: gameBottom)
        addGameObject(_object: gameTop)
        addGameObject(_object: player)
        for i in stride(from: 0, to: spikes1.count, by: 1) {
            addGameObject(_object: spikes1[i])
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        resetPositions()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Checking if the map has reached the end, if not then move it
        if (gameTop.position.x + gameTop.size.width/2 > size.width/2) {
        }
            // If map has finished moving, let the player know
        else {
            player.setLevelEnd()
        }
        
        // Pass the gravity over to the player
        player.handleGravity(_gravity: physicsWorld.gravity.dy)
        
        // Call our gameobject's update
        for i in stride(from: 0, to: gameObjectList.count, by: 1) {
           gameObjectList[i].update()
        }
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
