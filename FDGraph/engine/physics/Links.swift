//
//  GraphController.swift
//  hu.hevi.node.ios
//
//  Created by Hevi on 18/05/2019.
//  Copyright © 2019 Hevi. All rights reserved.
//

import CoreGraphics

public final class Links: Force {
    
    var distance: CGFloat = 40
        
    private var links: Set<Link> = []
    private var degrees: Dictionary<Node, UInt> = [:]
    private var linkBetweens = [LinkBetween]()
    
    public init() {
        
    }
    
    public func link(between a: Node, and b: Node, strength: CGFloat? = nil, distance: CGFloat? = nil) {
        let link = links.update(with: Link(between: a, and: b, strength: strength, distance: distance))
        if link == nil {
            degrees[a] = (degrees[a] ?? 0) + 1
            degrees[b] = (degrees[b] ?? 0) + 1
        } else if let link = link {
            linkBetweens.append(LinkBetween(a: a, b: b, link: link))
        }
    }

    public func unlink(between a: Node, and b: Node) {
        
        let linkBetween = linkBetweens.first { (linkBetween) -> Bool in
            linkBetween.a == a && linkBetween.b == b
        }
        if let link = linkBetween?.link {
            links.remove(link)
//        if links.remove(Link(between: a, and: b, strength: 0.3, distance: 400)) != nil {
            degrees[a] = (degrees[a] ?? 0) - 1
            degrees[b] = (degrees[b] ?? 0) - 1
        }
    }

    public func tick(alpha: CGFloat, particles: inout Set<Node>) {
        for link in links {            
            link.tick(alpha: alpha, degrees: degrees, distance: distance, particles: &particles)
        }
    }
    
    public func path(from particles: inout Set<Node>) -> CGPath {
        let path = CGMutablePath()
        for link in links {
            guard let fromIndex = particles.firstIndex(of: link.a),
                let toIndex = particles.firstIndex(of: link.b) else { continue }
            path.move(to: particles[fromIndex].position)
            path.addLine(to: particles[toIndex].position)
        }
        return path
    }
}

fileprivate struct Link: Hashable {
    let a: Node
    let b: Node
    let strength: CGFloat?
    let distance: CGFloat?
    
    init(between a: Node, and b: Node, strength: CGFloat? = nil, distance: CGFloat? = nil) {
        self.a = a
        self.b = b
        self.strength = strength
        self.distance = distance
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(a.hashValue)
        hasher.combine(b.hashValue)
    }
    
    public func tick(alpha: CGFloat, degrees: Dictionary<Node, UInt>, distance: CGFloat, particles: inout Set<Node>) {
        guard let fromIndex = particles.firstIndex(of: a),
            let toIndex = particles.firstIndex(of: b) else { return }
        
        var from = particles[fromIndex]
        var to = particles[toIndex]
        
        let fromDegree = CGFloat(degrees[a] ?? 0)
        let toDegree = CGFloat(degrees[b] ?? 0)
        
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

fileprivate class LinkBetween {
    
    public let a: Node
    public let b: Node
    public let link: Link
    
    init(a: Node, b: Node, link: Link) {
        self.a = a
        self.b = b
        self.link = link
    }
}

fileprivate func ==(lhs: Link, rhs: Link) -> Bool {
    return ((lhs.a == rhs.a && lhs.b == rhs.b) || (lhs.a == rhs.b && lhs.b == rhs.a))
}


