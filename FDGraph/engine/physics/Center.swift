//
//  GraphController.swift
//  hu.hevi.node.ios
//
//  Created by Hevi on 18/05/2019.
//  Copyright © 2019 Hevi. All rights reserved.
//

import CoreGraphics

public final class Center: Force {
    
    public var center: CGPoint
    
    public init(_ c: CGPoint) {
        center = c
    }
    
    public func tick(alpha: CGFloat, particles: inout Set<NodeParticle>) {
        let delta = center - (particles.reduce(.zero, { $0 + $1.position }) / CGFloat(particles.count))
        for particle in particles {
            guard !particle.fixed else { continue }
            particle.position += delta
            particles.update(with: particle)
        }
    }
}
