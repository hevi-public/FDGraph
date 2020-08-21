//
//  GraphController.swift
//  ForceDirectedNew
//
//  Created by Hevi on 13/03/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

// -MARK: DECLARATIONS
class GraphController: UIViewController {
    
    public static let GRAPH_CANVAS_SIZE: CGFloat = 50000
    
    private var graphViewContextMenuDelegate: GraphContextMenuInteractionDelegate!
    
    private lazy var scrollView: GraphScrollView = {
        let view = GraphScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = GraphController.GRAPH_CANVAS_SIZE
        view.contentSize.width = GraphController.GRAPH_CANVAS_SIZE
        view.frame = self.view.frame
        return view
    }()
    
    private lazy var graphView: GraphView = {
        return GraphView(width: GraphController.GRAPH_CANVAS_SIZE, height: GraphController.GRAPH_CANVAS_SIZE)
    }()
    
    // -MARK: SETUP
    public func setup(graphViewContextMenuDelegate: GraphContextMenuInteractionDelegate) {
        self.graphViewContextMenuDelegate = graphViewContextMenuDelegate
    }
    
    // -MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        print("GraphController viewDidLoad")

        
        scrollView.display(self.graphView)
        self.view.addSubview(scrollView)
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        scrollView.setup()

        
        
        self.view.isMultipleTouchEnabled = true
        self.graphView.isMultipleTouchEnabled = true
        
        let graphViewContextMenuInteraction = UIContextMenuInteraction(delegate: graphViewContextMenuDelegate)
        graphView.addInteraction(graphViewContextMenuInteraction)
        

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

}

// -MARK: PUBLIC METHODS
extension GraphController {
    
    public func add(node: Node, parent: Node? = nil) {
        self.graphView.add(node: node, parent: parent)
        self.select(node: node)
        
    }
    
    public func add(nodes: [Node]) {
        self.graphView.add(nodes: nodes)
    }
    
    public func link(between a: Node, and b: Node) {
        self.graphView.link(between: a, and: b)
    }
    
    public func add(edges: [Links]) {
        self.graphView.add(edges: edges)
    }
    
    public func focus(node: Node) {
        
        self.scrollView.scrollToView(view: node.view, animated: true)
        self.select(node: node)
    }
    
    public func select(node: Node) {
        Circle.removeAllGlow()
        node.view.addGlow()
    }
    
    public func delete(node: Node) {
        self.graphView.delete(node: node)
    }
    
    public func deleteSelectedNodes() {
        self.graphView.deleteSelectedNodes()
    }
}

extension GraphController {
    
    public func objectAtPoint(location: CGPoint) -> Node? {
        self.graphView.objectAtPoint(location: location)
    }
}

