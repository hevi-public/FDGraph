//
//  GraphController.swift
//  hu.hevi.node.ios
//
//  Created by Hevi on 18/05/2019.
//  Copyright © 2019 Hevi. All rights reserved.
//

import CoreGraphics

public typealias Charge = (strength: CGFloat, position: CGPoint)

public final class ManyParticle: Force {
    
    var strength: CGFloat = -175 // -75
    
    private var distanceMin2: CGFloat = 400
    private var distanceMax2: CGFloat = CGFloat.infinity
    private var theta2: CGFloat = 0.81
    
    public init() {
        
    }
    
    public func tick(alpha: CGFloat, particles: inout Set<NodeParticle>) {
        let tree = QuadTree(particles: particles,
                                    initial: { (strength, $0.position) },
                                    accumulator: { (children) -> Charge in
                                        var value = children.reduce((0, .zero), { (accumulated, child) -> Charge in
                                            guard let value = child?.value else { return accumulated }
                                            return (accumulated.strength + value.strength, accumulated.position + (value.position * value.strength))
                                            
                                        })
                                        value.position /= value.strength
                                        return value
                                    })
        
        for particle in particles {
            guard !particle.fixed else { continue }
            tree?.visit({ (quad) in
                let value = quad.value
                let width = quad.bounds.width
                let delta = (value.position - particle.position).jiggled
                
                var distance2 = delta.x * delta.x + delta.y * delta.y
                if distance2 < distanceMin2 {
                    distance2 = sqrt(distanceMin2 * distance2)
                }
                
                // Barnes-Hut approximation
                let barnesHut = (width * width / theta2 < distance2)
                
                if (barnesHut || quad.leaf) && distance2 < distanceMax2 {
                    particle.velocity += (delta * alpha * value.strength / distance2)
                }
                return barnesHut
            })
            particles.update(with: particle)
        }
    }
}
