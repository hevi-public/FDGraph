//
//  Graph.swift
//  FDGraph
//
//  Created by Hevi on 17/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

public class GraphEngine {
    
    private unowned var containerView: UIView
    
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
    
    public func add(node: Node, parent: Node? = nil) {
        
        simulation.particles.update(with: node)
        self.containerView.addSubview(node.view)
        
        if let parent = parent {
            
            node.position = CGPoint(x: parent.position.x + 10, y: parent.position.y + 10)
            self.link(between: node, and: parent)
        }
        
        simulation.kick()
    }
    
    public func add(nodes: [Node]) {
        nodes.forEach { (node) in
            simulation.particles.update(with: node)
            self.containerView.addSubview(node.view)
        }
    }
    
    public func link(between a: Node, and b: Node) {
        links.link(between: a, and: b, strength: 0.007)
    }
    
    public func add(edges: [Links]) {
        let nodes = Array(simulation.particles)
        
        links.link(between: nodes[0], and: nodes[1], strength: 0.007)
        links.link(between: nodes[2], and: nodes[1], strength: 0.007)
        links.link(between: nodes[2], and: nodes[3], strength: 0.007)
        links.link(between: nodes[2], and: nodes[4], strength: 0.007)
        links.link(between: nodes[2], and: nodes[5], strength: 0.007)
        links.link(between: nodes[2], and: nodes[6], strength: 0.007)
    }
    
    
}
