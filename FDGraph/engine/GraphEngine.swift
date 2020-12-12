//
//  Graph.swift
//  FDGraph
//
//  Created by Hevi on 17/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

// -MARK: DECLARATIONS / SETUP
public class GraphEngine {
    
    private unowned var containerView: UIView
    
    public var followedNode: NodeParticle?
    
    public lazy var simulation: Simulation = {
        let simulation: Simulation = Simulation()
        simulation.insert(force: self.manyParticle)
        simulation.insert(force: self.links)
        simulation.insert(force: self.center)
        simulation.insert(tick: { self.linkLayer.path = self.links.path(from: &$0) })
        return simulation
    }()
    
    private lazy var linkLayer: CAShapeLayer = {
        let linkLayer = CAShapeLayer()
        linkLayer.strokeColor = UIColor.gray.cgColor
        linkLayer.fillColor = UIColor.clear.cgColor
        linkLayer.lineWidth = 1
        self.containerView.layer.insertSublayer(linkLayer, at: 0)
        return linkLayer
    }()
    
    internal let center: Center!
    private let manyParticle: ManyParticle = ManyParticle()
    private let links: Links = Links()
    
    init(containerView: UIView) {
        self.containerView = containerView
        self.center = Center(CGPoint(x: self.containerView.frame.width / 2, y: self.containerView.frame.height / 2))
        self.simulation.start()
    }
}

// -MARK: PUBLIC METHODS

extension GraphEngine {
        
    // -MARK: ADD
    public func add(node: NodeParticle, parent: NodeParticle? = nil, contentType: ContentType) {
        
        simulation.particles.update(with: node)
        self.containerView.addSubview(node.circleContainer)
    
        if let parent = parent {
            
            node.position = CGPoint(x: parent.position.x + 10, y: parent.position.y + 10)
            self.link(between: node, and: parent)
        }
        
        simulation.kick()
    }
    
    public func add(nodes: [NodeParticle]) {
        nodes.forEach { (node) in
            self.add(node: node, contentType: .text)
        }
    }
    
    // -MARK: LINK
    public func link(between a: NodeParticle, and b: NodeParticle) {
        links.link(between: a, and: b, strength: 0.007)
        simulation.kick()
    }
    
    // -MARK: SELECT
    public func select(nodeParticle: NodeParticle) {
        nodeParticle.circleContainer.circle.addGlow()
    }
    
    public func deselect(nodeParticle: NodeParticle) {
        nodeParticle.circleContainer.circle.removeGlow()
    }

    // -MARK: DELETE
    public func delete(node: NodeParticle, shouldKick: Bool = true) {
        self.simulation.remove(particle: node)
        UIView.animate(withDuration: 0.3, animations: {
            node.circleContainer.alpha = 0
        }) { (completed) in
            node.circleContainer.removeFromSuperview()
        }
        
        if shouldKick {
            simulation.kick()
        }
    }
    
    public func deleteSelectedNodes() {
        
//        let selectedCircles = Circle.getSelectedCircles()
        
        let particles = Array(simulation.particles)
        
        // TODO
        
//        let selectedParticles = particles.filter { node -> Bool in
//            selectedCircles.contains(node.view)
//        }
//
//        selectedParticles.forEach { node in
//            delete(node: node, shouldKick: false)
//        }
        simulation.kick()
    }
}

extension GraphEngine {
    
    
    public func objectAtPoint(location: CGPoint) -> NodeParticle? {
        return self.simulation.particles.first { (viewParticle) -> Bool in
            return viewParticle.circleContainer.frame.contains(location)
        }
    }
}
