//
//  GraphView.swift
//  ForceDirectedNew
//
//  Created by Hevi on 13/03/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class GraphView: UIView {
    
    private lazy var graph: GraphEngine = {
        let graphEngine = GraphEngine(containerView: self)
        return graphEngine
    }()
    
    init(width: CGFloat, height: CGFloat) {
        
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
    
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GraphView {
    public func add(node: Node, parent: Node? = nil) {
        self.graph.add(node: node, parent: parent)
    }
    
    public func add(nodes: [Node]) {
        self.graph.add(nodes: nodes)
    }
    
    public func link(between a: Node, and b: Node) {
        self.graph.link(between: a, and: b)
    }
    
    public func add(edges: [Links]) {
        self.graph.add(edges: edges)
    }
}
