//
//  Animation.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/25/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

struct Animation {
    var textures: [SKTexture]?
    var frameTime: Double?
    
    func getAction() -> SKAction{
        let animation = SKAction.animate(with: textures!, timePerFrame: frameTime!)
        return animation
    }
    
    func getRepeatedAction() -> SKAction{
        let animation = SKAction.animate(with: textures!, timePerFrame: frameTime!)
        let repeatAnimation = SKAction.repeatForever(animation)
        return repeatAnimation
    }
}
