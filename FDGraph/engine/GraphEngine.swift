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
        simulation.insert(tick: {
            self.linkLayer.path = self.links.path(from: &$0)
            self.childrenLinkDraw()
            self.parentLinkDraw()
            self.preSelectedChildLinkDraw()
        })
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
    
    private lazy var selectedNodeChildrenLinkLayer: CAShapeLayer = {
        let selectedNodeLinkLayer = CAShapeLayer()
        selectedNodeLinkLayer.strokeColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        selectedNodeLinkLayer.fillColor = UIColor.clear.cgColor
        selectedNodeLinkLayer.lineWidth = 2.5
        self.containerView.layer.insertSublayer(selectedNodeLinkLayer, at: 1)
        return selectedNodeLinkLayer
    }()
    
    private lazy var preSelectedNodeChildrenLinkLayer: CAShapeLayer = {
        let selectedNodeLinkLayer = CAShapeLayer()
        selectedNodeLinkLayer.strokeColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        selectedNodeLinkLayer.fillColor = UIColor.clear.cgColor
        selectedNodeLinkLayer.lineWidth = 3.5
        self.containerView.layer.insertSublayer(selectedNodeLinkLayer, at: 2)
        return selectedNodeLinkLayer
    }()
    
    private lazy var selectedNodeParentLinkLayer: CAShapeLayer = {
        let selectedNodeLinkLayer = CAShapeLayer()
        selectedNodeLinkLayer.strokeColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        selectedNodeLinkLayer.fillColor = UIColor.clear.cgColor
        selectedNodeLinkLayer.lineWidth = 1.5
        self.containerView.layer.insertSublayer(selectedNodeLinkLayer, at: 3)
        return selectedNodeLinkLayer
    }()
    
    internal let center: Center!
    private let manyParticle: ManyParticle = ManyParticle()
    private let links: Links = Links()
    
    weak var selectedNode: Node?
    var glowingParticles: [NodeParticle] = []
    
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
        let siblingParticles = nodeParticle.node.parent?.children.map({ (node) -> NodeParticle in
            node.nodeParticle
        })
        siblingParticles?.forEach { (particle) in
            particle.circleContainer.circle.addGlow(color: UIColor.lightGray, opacity: 0.5)
        }
        
        nodeParticle.circleContainer.circle.addGlow(color: UIColor.orange, opacity: 1)
        if let siblingParticles = siblingParticles {
            glowingParticles.append(contentsOf: siblingParticles)
        }
        glowingParticles.append(nodeParticle)
        childrenLinkDraw()
        parentLinkDraw()
        preSelectedChildLinkDraw()
    }
    
    public func deselect(nodeParticle: NodeParticle) {
        //        nodeParticle.circleContainer.circle.removeGlow()
        glowingParticles.forEach { (particle) in
            particle.circleContainer.circle.removeGlow()
        }
        preSelectedChildLinkDraw()
    }
    
    public func preSelect() {
        
        preSelectedChildLinkDraw()
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
}

extension GraphEngine {
    
    public func objectAtPoint(location: CGPoint) -> NodeParticle? {
        return self.simulation.particles.first { (viewParticle) -> Bool in
            return viewParticle.circleContainer.frame.contains(location)
        }
    }
    
    private func childrenLinkDraw() {
        if let selectedNode = self.selectedNode {
            if let nodeParticle = selectedNode.nodeParticle {
                
                let childrenParticles = nodeParticle.node.children.map { (node) -> NodeParticle in
                    node.nodeParticle
                }
                
                self.selectedNodeChildrenLinkLayer.path = self.links.pathForSelectedAndChildren(selected: nodeParticle, children: childrenParticles)
            }
        }
    }
    
    private func preSelectedChildLinkDraw() {
        if let selectedNode = self.selectedNode,
           let selectedNodeParticle = selectedNode.nodeParticle,
           let preSelectedChildParticle = selectedNode.preSelectedChild?.nodeParticle {
           
                
                self.preSelectedNodeChildrenLinkLayer.path = self.links.pathForSelectedAndParent(selected: selectedNodeParticle, parent: preSelectedChildParticle)
            
        } else {
            self.preSelectedNodeChildrenLinkLayer.path = nil
        }
    }
    
    private func parentLinkDraw() {
        if let selectedNode = self.selectedNode,
           let nodeParticle = selectedNode.nodeParticle,
           let parent = selectedNode.parent,
           let parentParticle = parent.nodeParticle {
            
            
            self.selectedNodeParentLinkLayer.path = self.links.pathForSelectedAndParent(selected: nodeParticle, parent: parentParticle)
        }
        
    }
}
