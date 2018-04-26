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
    var player: Player = Player()
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
    
    // Our particle effect
    // TO DO : Figure out a way to display it once since reset simulation isn't reliable
    var gravityParticle: SKEmitterNode = SKEmitterNode()
    
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
    
    private func addGameObjects(_objects: [GameObject]) {
        for obj in _objects {
            gameObjectList.append(obj)
            addChild(obj)
        }
    }
    
    // Function to reset the level on loss condition
    private func resetGame() {
        removeAllChildren()
        gameObjectList.removeAll()
        initGame()
    }
    
    // Spawns a particle effect using the given file name and positionx
    private func spawnParticleEffect(_position: CGPoint, _fileName: String) -> SKEmitterNode{
        let particle = SKEmitterNode(fileNamed: _fileName)
        particle?.name = "test"
        particle?.position = _position
        particle?.targetNode = self
        addChild(particle!)
        return particle!
    }
    
    
    private func initGame() {
        
        player = Player()
        
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
        spikes1 = SpikeFactory.createSpikes(_position: CGPoint(x: 20, y: -135), _numberOfSpikes: 15, _flipped: false)
        spikes2 = SpikeFactory.createSpikes(_position: CGPoint(x: 675, y: -135), _numberOfSpikes: 10, _flipped: false)
        spikes3 = SpikeFactory.createSpikes(_position: CGPoint(x: 1015, y: -110), _numberOfSpikes: 14, _flipped: false)
        spikes4 = SpikeFactory.createSpikes(_position: CGPoint(x: 1900, y: -110), _numberOfSpikes: 8, _flipped: false)
        spikes5 = SpikeFactory.createSpikes(_position: CGPoint(x: 2275, y: -110), _numberOfSpikes: 8, _flipped: false)
        spikes6 = SpikeFactory.createSpikes(_position: CGPoint(x: 1400, y: -85), _numberOfSpikes: 6, _flipped: false)
        spikes7 = SpikeFactory.createSpikes(_position: CGPoint(x: 1850, y: -85), _numberOfSpikes: 3, _flipped: false)
        spikes8 = SpikeFactory.createSpikes(_position: CGPoint(x: 2200, y: -85), _numberOfSpikes: 6, _flipped: false)
        
        // Top Spikes
        spikes9 = SpikeFactory.createSpikes(_position: CGPoint(x: -200, y: 135), _numberOfSpikes: 20, _flipped: true)
        spikes10 = SpikeFactory.createSpikes(_position: CGPoint(x: 950, y: 60), _numberOfSpikes: 3, _flipped: true)
        spikes11 = SpikeFactory.createSpikes(_position: CGPoint(x: 725, y: 135), _numberOfSpikes: 18, _flipped: true)
        spikes13 = SpikeFactory.createSpikes(_position: CGPoint(x: 275, y: 110), _numberOfSpikes: 10, _flipped: true)
        spikes14 = SpikeFactory.createSpikes(_position: CGPoint(x: 1200, y: 110), _numberOfSpikes: 15, _flipped: true)
        spikes15 = SpikeFactory.createSpikes(_position: CGPoint(x: 2050, y: 110), _numberOfSpikes: 12, _flipped: true)
        spikes16 = SpikeFactory.createSpikes(_position: CGPoint(x: 2450, y: 60), _numberOfSpikes: 6, _flipped: true)
        
        gravityParticle = spawnParticleEffect(_position: CGPoint(x: -100, y: 0), _fileName: "GravityParticle.sks")
    
        // Our scene objects added here
        addChild(background)
        addChild(winText)
        addGameObject(_object: gameBottom)
        addGameObject(_object: gameTop)
        addGameObject(_object: player)
        addGameObjects(_objects: spikes1)
        addGameObjects(_objects: spikes2)
        addGameObjects(_objects: spikes3)
        addGameObjects(_objects: spikes4)
        addGameObjects(_objects: spikes5)
        addGameObjects(_objects: spikes6)
        addGameObjects(_objects: spikes7)
        addGameObjects(_objects: spikes8)
        addGameObjects(_objects: spikes9)
        addGameObjects(_objects: spikes10)
        addGameObjects(_objects: spikes11)
        addGameObjects(_objects: spikes13)
        addGameObjects(_objects: spikes14)
        addGameObjects(_objects: spikes15)
        addGameObjects(_objects: spikes16)
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
            // gravityParticle.resetSimulation() // This function is extremely slow so we're scrapping it for now
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
