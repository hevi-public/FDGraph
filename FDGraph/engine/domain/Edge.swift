//
//  Edge.swift
//  FDGraph
//
//  Created by Hevi on 15/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics


struct Edge: Hashable {
    let from: NodeParticle
    let to: NodeParticle
    let strength: CGFloat?
    let distance: CGFloat?
    let weight: CGFloat
    
    init(between from: NodeParticle, and to: NodeParticle, weight: CGFloat = 1, strength: CGFloat? = nil, distance: CGFloat? = nil) {
        self.from = from
        self.to = to
        self.strength = strength
        self.distance = distance
        self.weight = weight
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(from.hashValue)
        hasher.combine(to.hashValue)
    }
    
    public func tick(alpha: CGFloat, degrees: Dictionary<NodeParticle, UInt>, distance: CGFloat, particles: inout Set<NodeParticle>) {
//        guard let fromIndex = particles.firstIndex(of: from),
//            let toIndex = particles.firstIndex(of: to) else { return }
//
//        var fromNode = particles[fromIndex]
//        var toNode = particles[toIndex]
        
        let fromDegree = CGFloat(degrees[from] ?? 0)
        let toDegree = CGFloat(degrees[to] ?? 0)
        
        let bias = fromDegree / (fromDegree + toDegree)
        let distance = (self.distance ?? distance)
        let strength = (self.strength ?? 0.7 / CGFloat(min(fromDegree, toDegree)))
        
        let delta = (to.position + to.velocity - from.position - from.velocity).jiggled
        let magnitude = delta.magnitude
        let value = delta * ((magnitude - distance) / magnitude) * alpha * strength
        
        to.velocity -= value * bias;
        from.velocity += (value * (1 - bias))
        
        particles.update(with: from)
        particles.update(with: to)
    }
}



//fileprivate func ==<T: Particle>(lhs: Link, rhs: Link) -> Bool {
//    return ((lhs.a == rhs.a && lhs.b == rhs.b) || (lhs.a == rhs.b && lhs.b == rhs.a))
//}
//
//fileprivate class LinkBetween<T: Particle> {
//
//    public let a: T
//    public let b: T
//    public let link: Link
//
//    init(a: T, b: T, link: Link) {
//        self.a = a
//        self.b = b
//        self.link = link
//    }
//}
