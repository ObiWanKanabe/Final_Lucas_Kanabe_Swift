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
    
    override func didMove(to view: SKView) {
        addChild(background)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
