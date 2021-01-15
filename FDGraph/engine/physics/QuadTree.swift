//
//  GraphController.swift
//  hu.hevi.node.ios
//
//  Created by Hevi on 18/05/2019.
//  Copyright © 2019 Hevi. All rights reserved.
//

import CoreGraphics
import UIKit

public enum QuadTree {
    case Leaf(CGPoint, Charge)
    indirect case Internal(CGRect, QuadTree?, QuadTree?, QuadTree?, QuadTree?, Charge)
    
    init?<PARTICLE: Particle, COLLECTION: Collection>(particles: COLLECTION, initial: (PARTICLE) -> Charge, accumulator: ([QuadTree?]) -> Charge) where COLLECTION.Iterator.Element == PARTICLE {
        
        guard let rect = particles.map({ $0.position }).boundingRect else { return nil }
        self.init(particles: particles, rect: rect, initial: initial, accumulator: accumulator)
    }
    
    init?<PARTICLE: Particle, COLLECTION: Collection>(particles: COLLECTION, rect: CGRect, initial: (PARTICLE) -> Charge, accumulator: ([QuadTree?]) -> Charge) where COLLECTION.Iterator.Element == PARTICLE {
        
        let count = particles.count
        guard count > 0 else { return nil }
        if let particle = particles.first, count == 1 {
            self = .Leaf(particle.position, initial(particle))
        } else {
            let width = rect.width / 2
            let height = rect.height / 2
            let minX = rect.minX, midX = rect.midX, minY = rect.minY, midY = rect.midY
            let topLeft = CGRect(x: minX, y: minY, width: width, height: height)
            let topRight = CGRect(x: midX, y: minY, width: width, height: height)
            let bottomLeft = CGRect(x: minX, y: midY, width: width, height: height)
            let bottomRight = CGRect(x: midX, y: midY, width: width, height: height)
            
            var topLeftParticles: [PARTICLE] = []
            var topRightParticles: [PARTICLE] = []
            var bottomLeftParticles: [PARTICLE] = []
            var bottomRightParticles: [PARTICLE] = []
            
            for particle in particles {
                let position = particle.position
                if topLeft.contains(position) {
                    topLeftParticles.append(particle)
                } else if topRight.contains(position) {
                    topRightParticles.append(particle)
                } else if bottomLeft.contains(position) {
                    bottomLeftParticles.append(particle)
                } else if bottomRight.contains(position) {
                    bottomRightParticles.append(particle)
                }
            }
            
            let topLeftTree = QuadTree(particles: topLeftParticles, rect: topLeft, initial: initial, accumulator: accumulator)
            let topRightTree = QuadTree(particles: topRightParticles, rect: topRight, initial: initial, accumulator: accumulator)
            let bottomLeftTree = QuadTree(particles: bottomLeftParticles, rect: bottomLeft, initial: initial, accumulator: accumulator)
            let bottomRightTree = QuadTree(particles: bottomRightParticles, rect: bottomRight, initial: initial, accumulator: accumulator)
            let value = accumulator([topLeftTree, topRightTree, bottomLeftTree, bottomRightTree])
            self = .Internal(rect, topLeftTree, topRightTree, bottomLeftTree, bottomRightTree, value)
        }
    }
    
    var leaf: Bool {
        if case .Leaf = self {
            return true
        }
        return false
    }
    
    var bounds: CGRect {
        switch self {
        case let .Leaf(position, _):
            return CGRect(origin: position, size: .zero)
        case let .Internal(bounds, _, _, _, _, _):
            return bounds
        }
    }
    
    var value: Charge {
        switch self {
        case let .Leaf(_, value):
            return value
        case let .Internal(_, _, _, _, _, value):
            return value
        }
    }
    
    func visit(_ f: (QuadTree) -> Bool) {
        if f(self) {
            return
        }
        
        if case let .Internal(_, a, b, c, d, _) = self {
            a?.visit(f)
            b?.visit(f)
            c?.visit(f)
            d?.visit(f)
        }
    }
}
