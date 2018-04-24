//
//  SpikeFactory.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/23/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import Foundation
import SpriteKit

class KidFactory {
    
    func generateSpike(_position: CGPoint) {
        let spike = Spike()
        spike.position = _position
    }
    
    func createSpikes(_position: CGPoint, _numberOfSpikes: Int) {
        for i in stride(from: 0, to: _numberOfSpikes, by: 1) {
            generateSpike(_position: CGPoint(x: _position.x + CGFloat(i*7), y: _position.y))
        }
    }
    
}

