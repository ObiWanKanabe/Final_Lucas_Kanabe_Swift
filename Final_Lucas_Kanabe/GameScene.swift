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
    
    // Bottom Spikes
    var spikes1: [Spike] = []
    var spikes2: [Spike] = []
    var spikes3: [Spike] = []
    var spikes4: [Spike] = []
    var spikes5: [Spike] = []
    var spikes6: [Spike] = []
    var spikes7: [Spike] = []
    var spikes8: [Spike] = []
    
    // Top Spikes
    var spikes9: [Spike] = []
    var spikes10: [Spike] = []
    var spikes11: [Spike] = []
    var spikes13: [Spike] = []
    var spikes14: [Spike] = []
    var spikes15: [Spike] = []
    var spikes16: [Spike] = []
    
    // List of the GameObjects in the scene
    var gameObjectList : [GameObject] = []
    
    // Win Text (behind the background for now)
    lazy var winText: SKLabelNode = {
        var text = SKLabelNode(fontNamed: "Arial")
        text.fontSize = CGFloat(75)
        text.zPosition = -2
        text.color = SKColor.white
        text.horizontalAlignmentMode = .center
        text.verticalAlignmentMode = .bottom
        text.text = "YOU WIN!"
        return text
    }()
    
    override func didMove(to view: SKView) {
        // Init objects and properties
        initGame()
    }
    
    // Every GameObject in our scene needs to be added to the list to call their update
    private func addGameObject(_object: GameObject) {
        gameObjectList.append(_object)
        addChild(_object)
    }
    
    // Function to reset the level on loss condition
    private func resetGame() {
        removeAllChildren()
        gameObjectList.removeAll()
        initGame()
    }
    
    private func initGame() {
        
        // Set the Physics World contact delegate
        physicsWorld.contactDelegate = self
        
        // Set Player position and let it know what the screen bounds are
        player.position = CGPoint(x: -size.width/2 + 100, y: 0)
        player.setScreenbounds(_leftX: -size.width/2, _rightX: size.width/2)
        
        // Set the map halves position
        gameTop.position = CGPoint(x: -size.width/2 + gameTop.size.width/2, y: size.height/2 - gameTop.size.height/2 )
        gameTop.zPosition = 1
        gameBottom.position = CGPoint(x: -size.width/2 + gameBottom.size.width/2, y : -size.height/2 + gameBottom.size.height/2)
        gameBottom.zPosition = 1
        
        // Set gravity to be a little lower but normal direction downward to start
        physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        
        // Make sure background is behind everything
        background.zPosition = -1
        
        // Bottom Spikes
        spikes1 = SpikeFactory.createSpikes(_position: CGPoint(x: 20, y: -135), _numberOfSpikes: 15)
        spikes2 = SpikeFactory.createSpikes(_position: CGPoint(x: 675, y: -135), _numberOfSpikes: 10)
        spikes3 = SpikeFactory.createSpikes(_position: CGPoint(x: 1015, y: -110), _numberOfSpikes: 14)
        spikes4 = SpikeFactory.createSpikes(_position: CGPoint(x: 1900, y: -110), _numberOfSpikes: 8)
        spikes5 = SpikeFactory.createSpikes(_position: CGPoint(x: 2275, y: -110), _numberOfSpikes: 8)
        spikes6 = SpikeFactory.createSpikes(_position: CGPoint(x: 1400, y: -85), _numberOfSpikes: 6)
        spikes7 = SpikeFactory.createSpikes(_position: CGPoint(x: 1850, y: -85), _numberOfSpikes: 3)
        spikes8 = SpikeFactory.createSpikes(_position: CGPoint(x: 2200, y: -85), _numberOfSpikes: 6)
        
        // Top Spikes
        spikes9 = SpikeFactory.createSpikes(_position: CGPoint(x: -200, y: 135), _numberOfSpikes: 20)
        spikes10 = SpikeFactory.createSpikes(_position: CGPoint(x: 950, y: 60), _numberOfSpikes: 3)
        spikes11 = SpikeFactory.createSpikes(_position: CGPoint(x: 725, y: 135), _numberOfSpikes: 18)
        spikes13 = SpikeFactory.createSpikes(_position: CGPoint(x: 275, y: 110), _numberOfSpikes: 10)
        spikes14 = SpikeFactory.createSpikes(_position: CGPoint(x: 1200, y: 110), _numberOfSpikes: 15)
        spikes15 = SpikeFactory.createSpikes(_position: CGPoint(x: 2050, y: 110), _numberOfSpikes: 12)
        spikes16 = SpikeFactory.createSpikes(_position: CGPoint(x: 2450, y: 60), _numberOfSpikes: 6)
    
        // Our scene objects added here
        addChild(background)
        addChild(winText)
        addGameObject(_object: gameBottom)
        addGameObject(_object: gameTop)
        addGameObject(_object: player)
        
        // Adding Spikes
        // TO DO : PUT THIS SOMEWHERE ELSE
        for spikes in spikes1 {
            addGameObject(_object: spikes)
        }
        
        for spikes in spikes2 {
            addGameObject(_object: spikes)
        }
        
        for spikes in spikes3 {
            addGameObject(_object: spikes)
        }
        
        for spikes in spikes4 {
            addGameObject(_object: spikes)
        }
        
        for spikes in spikes5 {
            addGameObject(_object: spikes)
        }
        
        for spikes in spikes6 {
            addGameObject(_object: spikes)
        }
        
        for spikes in spikes7 {
            addGameObject(_object: spikes)
        }
        
        for spikes in spikes8 {
            addGameObject(_object: spikes)
        }
        
        for spikes in spikes9 {
            addGameObject(_object: spikes)
            spikes.setFlipped()
        }
        
        for spikes in spikes10 {
            addGameObject(_object: spikes)
            spikes.setFlipped()
        }
        
        for spikes in spikes11 {
            addGameObject(_object: spikes)
            spikes.setFlipped()
        }
        
        for spikes in spikes13 {
            addGameObject(_object: spikes)
            spikes.setFlipped()
        }
        
        for spikes in spikes14 {
            addGameObject(_object: spikes)
            spikes.setFlipped()
        }
        
        for spikes in spikes15 {
            addGameObject(_object: spikes)
            spikes.setFlipped()
        }
        
        for spikes in spikes16 {
            addGameObject(_object: spikes)
            spikes.setFlipped()
        }
    }
    
    // On contact with spikes
    func didBegin(_ contact: SKPhysicsContact) {
        resetGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Checking if the map has reached the end, if not then move it
        if (gameTop.position.x + gameTop.size.width/2 > size.width/2) {
        }
            // If map has finished moving, let the objects know
        else {
            for obj in gameObjectList {
                obj.setLevelEnd(_result: true)
            }
        }
        
        // If the player finishes the level, show the win text
        if (player.position.x > size.width/2) {
            winText.zPosition = 2
        }
        
        // If the player falls behind the level, reset the game
        if (player.position.x < -size.width/2) {
            resetGame()
        }
        
        // Pass the gravity over to the player
        player.handleGravity(_gravity: physicsWorld.gravity.dy)
        
        // Call our gameobject's update
        for obj in gameObjectList {
           obj.update()
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
