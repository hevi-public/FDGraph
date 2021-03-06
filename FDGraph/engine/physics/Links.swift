//
//  GraphController.swift
//  hu.hevi.node.ios
//
//  Created by Hevi on 18/05/2019.
//  Copyright © 2019 Hevi. All rights reserved.
//

import CoreGraphics

public final class Links: Force {
    
    private var DEFAULT_DISTANCE: CGFloat = 40
        
    private var links: Set<Link> = []
    private var degrees: Dictionary<NodeParticle, UInt> = [:]
    private var linkBetweens = [LinkBetween]()
    
    public init() {
        
    }
    
    public func link(between a: NodeParticle, and b: NodeParticle, strength: CGFloat? = nil, distance: CGFloat? = nil) {
        let link = Link(between: a, and: b, strength: strength, distance: distance)
        linkBetweens.append(LinkBetween(a: a, b: b, link: link))
        
        let updatedLink = links.update(with: link)
        if updatedLink == nil {
            degrees[a] = (degrees[a] ?? 0) + 1
            degrees[b] = (degrees[b] ?? 0) + 1
        }
//        else if let link = link {
//            linkBetweens.append(LinkBetween(a: a, b: b, link: link))
//        }
    }

    public func unlink(between a: NodeParticle, and b: NodeParticle) {
        
        let linkBetween = linkBetweens.first { (linkBetween) -> Bool in
            linkBetween.a == a && linkBetween.b == b || linkBetween.a == b && linkBetween.b == a // TODO REMOVE OR, MAKE PARAMETERS EXPLICIT PARENT-CHILD? FROM-TO?
        }
        if let link = linkBetween?.link {
            links.remove(link)
//        if links.remove(Link(between: a, and: b, strength: 0.3, distance: 400)) != nil {
            degrees[a] = (degrees[a] ?? 0) - 1
            degrees[b] = (degrees[b] ?? 0) - 1
        }
    }

    public func tick(alpha: CGFloat, particles: inout Set<NodeParticle>) {
        for link in links {            
            link.tick(alpha: alpha, degrees: degrees, distance: DEFAULT_DISTANCE, particles: &particles)
        }
    }
    
    public func path(from particles: inout Set<NodeParticle>) -> CGPath {
        let path = CGMutablePath()
        for link in links {
            guard let fromIndex = particles.firstIndex(of: link.a),
                let toIndex = particles.firstIndex(of: link.b) else { continue }
            path.move(to: particles[fromIndex].position)
            path.addLine(to: particles[toIndex].position)
        }
        return path
    }
    
    public func pathForSelectedAndChildren(selected: NodeParticle, children: [NodeParticle]) -> CGPath {
        let path = CGMutablePath()
        for child in children {
            path.move(to: selected.position)
            path.addLine(to: child.position)
        }
        return path
    }
    
    public func pathForSelectedAndParent(selected: NodeParticle, parent: NodeParticle) -> CGPath {
        let path = CGMutablePath()
        path.move(to: selected.position)
        path.addLine(to: parent.position)
        return path
    }
}

fileprivate struct Link: Hashable {
    let a: NodeParticle
    let b: NodeParticle
    let strength: CGFloat?
    let distance: CGFloat?
    
    init(between a: NodeParticle, and b: NodeParticle, strength: CGFloat? = nil, distance: CGFloat? = nil) {
        self.a = a
        self.b = b
        self.strength = strength
        self.distance = distance
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(a.hashValue)
        hasher.combine(b.hashValue)
    }
    
    public func tick(alpha: CGFloat, degrees: Dictionary<NodeParticle, UInt>, distance: CGFloat, particles: inout Set<NodeParticle>) {
        guard let fromIndex = particles.firstIndex(of: a),
            let toIndex = particles.firstIndex(of: b) else { return }
        
        let from = particles[fromIndex]
        let to = particles[toIndex]
        
        let fromDegree = CGFloat(degrees[a] ?? 0)
        let toDegree = CGFloat(degrees[b] ?? 0)
        
        let bias = fromDegree / (fromDegree + toDegree)
        
        let dist = calculateDist(to: to, from: from, distance: self.distance ?? distance)
        
        let distance = (dist)
        let strength = (self.strength ?? 0.7 / CGFloat(min(fromDegree, toDegree)))
        
        let delta = (to.position + to.velocity - from.position - from.velocity).jiggled
        let magnitude = delta.magnitude
        let value = delta * ((magnitude - distance) / magnitude) * alpha * strength
        
        to.velocity -= value * bias;
        from.velocity += (value * (1 - bias))
        
        particles.update(with: from)
        particles.update(with: to)
    }
    
    private func calculateDist(to: NodeParticle, from: NodeParticle, distance: CGFloat) -> CGFloat {
        let distWidth = max(from.circleContainer.frame.width, to.circleContainer.frame.width)
        let distHeight = max(from.circleContainer.frame.height, to.circleContainer.frame.height)
        let distDimension = max(distWidth, distHeight)
        return max(distDimension, distance)
    }
}

fileprivate class LinkBetween {
    
    public let a: NodeParticle
    public let b: NodeParticle
    public let link: Link
    
    init(a: NodeParticle, b: NodeParticle, link: Link) {
        self.a = a
        self.b = b
        self.link = link
    }
}

fileprivate func ==(lhs: Link, rhs: Link) -> Bool {
    return ((lhs.a == rhs.a && lhs.b == rhs.b) || (lhs.a == rhs.b && lhs.b == rhs.a))
}


