//
//  SpikeFactory.swift
//  Final_Lucas_Kanabe
//
//  Created by Kanabe Lucas A. on 4/23/18.
//  Copyright © 2018 Kanabe Lucas A. All rights reserved.
//

import Foundation
import SpriteKit

class SpikeFactory {
    
    static func generateSpike(_position: CGPoint) -> Spike{
        let spike = Spike()
        spike.position = _position
        return spike
    }
    
    static func createSpikes(_position: CGPoint, _numberOfSpikes: Int) -> [Spike] {
        var spikes: [Spike] = []
        for i in stride(from: 0, to: _numberOfSpikes, by: 1) {
            spikes.append(generateSpike(_position: CGPoint(x: _position.x + CGFloat(i*7), y: _position.y)))
        }
        return spikes
    }
}

