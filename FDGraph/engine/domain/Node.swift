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
    
    func handleSingleTap(node: NodeParticle)
    func handleDoubleTap(node: NodeParticle)
}

class Node {
    
    public var delegate: NodeDelegate?
    
    private var _nodeParticle: NodeParticle?
    public var nodeParticle: NodeParticle {
        get {
            if _nodeParticle == nil {
                _nodeParticle = NodeParticle(radiusMultiplier: 1.0, contentType: .text)
            }
            return _nodeParticle!
        }
    }
    
    let id: Int?
    var parent: Node?
    let text: String
    let type: NodeType
    var children: [Node]
    
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
    
    init(id: Int?, parent: Node? = nil, children: [Node] = [], text: String, expanded: Bool = false, done: Bool = false, type: NodeType = .text) {
        self.id = id
        self.parent = parent
        self.children = children
        self.text = text
        self.expanded = expanded
        self.done = done
        self.type = type
    }
}

extension Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
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
    
    func hash(into hasher: inout Hasher) {
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
