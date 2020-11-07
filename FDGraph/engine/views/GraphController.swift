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
    
    private var graph: GraphEngine {
        get {
            return self.graphView.graph
        }
    }
    
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

    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        var didHandleEvent = false
        for press in presses {
            guard let key = press.key else { continue }
            
            //            if self.isFirstResponder {
            if key.charactersIgnoringModifiers == UIKeyCommand.inputUpArrow || key.characters == "i" {
                scrollView.scrollUp()
                didHandleEvent = true
            } else if key.charactersIgnoringModifiers == UIKeyCommand.inputDownArrow || key.characters == "k" {
                scrollView.scrollDown()
                didHandleEvent = true
            } else if key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow || key.characters == "j" {
                scrollView.scrollLeft()
                didHandleEvent = true
            } else if key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow || key.characters == "l" {
                scrollView.scrollRight()
                didHandleEvent = true
            } else if key.characters == "u" {
                scrollView.zoomIn()
                didHandleEvent = true
            } else if key.characters == "o" {
                scrollView.zoomOut()
                didHandleEvent = true
            }
        }
        
        if didHandleEvent == false {
            // Didn't handle this key press, so pass the event to the next responder.
            super.pressesBegan(presses, with: event)
        }
        
    }
}

// -MARK: PUBLIC METHODS
extension GraphController {
    
    public func add(node: Node, parent: Node? = nil, contentType: ContentType) {
        self.graph.add(node: node, parent: parent, contentType: contentType)
        self.select(node: node)
        
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
    
    public func focus(node: Node) {
        
        self.scrollView.scrollToView(view: node.circleContainer, animated: true)
        self.select(node: node)
    }
    
    public func edit(node: Node) {
        switch node.circleContainer.contentType {
        case .text:
            let textView = node.circleContainer.content as! GraphTextNode
            textView.textView.becomeFirstResponder()
        case .none:
            break
        }
        
    }
    
    public func follow(node: Node?) {
        self.graph.followedNode = node
        if let node = node {
            self.graph.simulation.tickCallback = {
                self.scrollView.scrollToView(view: node.circleContainer, animated: false)
            }
        }
    }
    
    public func selectedNode() -> Node? {
        let selectedCircles = Circle.getSelectedCircles()
        if !selectedCircles.isEmpty {
            let nodes = Array(self.graph.simulation.particles)
            return nodes.filter { node -> Bool in
                node.circleContainer.circle == selectedCircles[0]
            }.first
        }
        return nil
        
    }
    
    public func select(node: Node) {
        Circle.removeAllGlow()
        node.circleContainer.circle.addGlow()
    }
    
    public func delete(node: Node) {
        self.graph.delete(node: node)
    }
    
    public func deleteSelectedNodes() {
        self.graph.deleteSelectedNodes()
    }
}

extension GraphController {
    
    public func objectAtPoint(location: CGPoint) -> Node? {
        self.graph.objectAtPoint(location: location)
    }
}

