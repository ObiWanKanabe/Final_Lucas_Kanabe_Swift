//
//  Spike.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/23/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import SpriteKit
import Foundation

class Spike: GameObject {
    override func initialize() {
         name = "Spike"
    }
    
    override func update() {
        
    }
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture.init(imageNamed: "spike.png")
        
        super.init(texture: texture, color: .clear, size: CGSize(width: texture.size().width * 1.25, height: texture.size().height * 1.25))
        initialize()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

