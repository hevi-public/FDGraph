//
//  Node.swift
//  FDGraph
//
//  Created by Hevi on 13/11/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

public protocol NodeDelegate {
    
    func handleSingleTap(node: Node)
    func handleDoubleTap(node: Node)
    func handleDragged(node: Node, gestureRecognizer: UIGestureRecognizer)
    
    func save(node: Node)
}

public class Node {
    
    public var delegate: NodeDelegate?
    
    public var nodeParticle: NodeParticle!
    
    let id: Int?
    private var _parent: Node? = nil
    var parent: Node? {
        get {
            return _parent
        }
        set {
            self._parent = newValue
            _parent?.addChild(node: self)
            _parent?.updateValue()
        }
    }
    var text: String
    let type: NodeType
    var children: [Node]
    var preSelectedChild: Node? = nil
    var lastSelectedChild: Node? = nil
    
    var expanded: Bool
    var expandable: Bool {
        get {
            return children.count > 0 && !expanded
            //            guard let nodeEntity = self.nodeEntity else { return false }
            //            guard let children = nodeEntity.children else { return false }
            //            return !nodeEntity.expanded && !self.isLinkType && children.count > 0
        }
    }
    var done: Bool
    
    var cell: UITableViewCell?
    
    public var depth: Int {
        get {
            guard let parent = self.parent else { return 0 }
            return parent.depth + 1
        }
    }
    
    var value: Double {
//        let linkedToCount = ((linkedTo?.count ?? 0) == 0) ? 0 : (linkedTo?.count ?? 0)
//        let linkedByCount = ((linkedBy?.count ?? 0) == 0) ? 0 : (linkedBy?.count ?? 0)
        
        var returnValue = 1.0
//            + Double(linkedToCount) + Double(linkedByCount)
        
        for child in children {
            returnValue += child.value
        }
        
        
//        let connectionSum = linkedToCount + linkedByCount + childrenCount
//        let weightedConnections = (connectionSum + linkedByCount)
//        let result = (Double(weightedConnections) + (Double(group)) * Double(weightedConnections) / 8) / 20
//        return result
        return returnValue
    }
    
    var root: Node? {
        if parent != nil {
            return parent?.root
        } else {
            return self
        }
    }
    
    var childNodesInTree: [Node] {
        var returnValue: [Node] = []
        
        for child in children {
            returnValue.append(contentsOf: child.childNodesInTree)
        }
        
        returnValue.append(self)
        
        return returnValue
    }
    
    private var _fixed: Bool = false
    var fixed: Bool {
        get {
            _fixed
        }
        set {
            _fixed = newValue
            nodeParticle.fixed = newValue
            nodeParticle.updateCircleColor()
        }
    }
    
    var color: UIColor {
        get {
            if fixed {
                return UIColor.green
            } else {
                return UIColor.blue
            }
        }
    }
    
    init(id: Int?,
         parent: Node? = nil,
         text: String,
         expanded: Bool = false,
         done: Bool = false,
         type: NodeType = .text,
         fixed: Bool = false,
         position: CGPoint? = nil) {
        self.id = id
        self.children = []
        self.text = text
        self.expanded = expanded
        self.done = done
        self.type = type
        self.parent = parent
        
        self.nodeParticle = NodeParticle(graphUITextdelegate: self,
                                         radiusMultiplier: 1.0,
                                         contentType: .text,
                                         node: self)
        nodeParticle.delegate = self
        nodeParticle.updateCircleSize()
        nodeParticle.updateCircleColor()
        
        self.fixed = fixed
        if let position = position {
            self.nodeParticle.position = position
            nodeParticle.updateContainerPosition()
        }
        
        
    }
    
    func updateValue() {
        if value != 0 {
            nodeParticle.updateCircleSize()
        }
        parent?.updateValue()
    }
    
    func addChild(node: Node) {
        self.children.append(node)
        _parent?.updateValue()
    }
}

extension Node: Equatable {
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.id == rhs.id &&
            lhs.parent == rhs.parent &&
            lhs.text == rhs.text &&
            lhs.type == rhs.type &&
            lhs.children == rhs.children &&
            lhs.expanded == rhs.expanded &&
            lhs.expandable == rhs.expandable &&
            lhs.done == rhs.done &&
            lhs.depth == rhs.depth
    }
}

extension Node: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(parent)
        hasher.combine(text)
        hasher.combine(type)
        hasher.combine(children)
        hasher.combine(expanded)
        hasher.combine(expandable)
        hasher.combine(done)
        hasher.combine(depth)
    }
}

enum NodeType {
    case text
    case input
}

extension Node: NodeParticleDelegate {
    public func handleSingleTap(particle: NodeParticle) {
        self.delegate?.handleSingleTap(node: particle.node)
    }
    
    public func handleDoubleTap(particle: NodeParticle) {
        self.delegate?.handleDoubleTap(node: particle.node)
    }
    
    public func handleDragged(particle: NodeParticle, gestureRecognizer: UIGestureRecognizer) {
        self.delegate?.handleDragged(node: particle.node, gestureRecognizer: gestureRecognizer)
    }
    
}

extension Node: GraphUITextDelegate {
    public func shouldSave(text: String) {
        print("shouldSave Delegate")
        self.text = text
        self.delegate?.save(node: self)
    }
    
    public func shouldCancel() {
        print("shouldCancel Delegate")
    }
}

