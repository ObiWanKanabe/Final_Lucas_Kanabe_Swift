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
    
    // Generation of one single spike
    private static func generateSpike(_position: CGPoint) -> Spike{
        let spike = Spike()
        spike.position = _position
        return spike
    }
    
    // Create spikes from the position and using the number of spikes given
    static func createSpikes(_position: CGPoint, _numberOfSpikes: Int, _flipped: Bool) -> [Spike] {
        var spikes: [Spike] = []
        for i in stride(from: 0, to: _numberOfSpikes, by: 1) {
            let spike : Spike = generateSpike(_position: CGPoint(x: _position.x + CGFloat(i*7), y: _position.y))
            if (_flipped == true) {
            spike.setFlipped()
            }
            spikes.append(spike)
        }
        return spikes
    }
}

