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
    private var nodeDelegate: NodeDelegate!
    
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
    
    var graph: GraphEngine {
        get {
            return self.graphView.graph
        }
    }
    
    public var selectedNode: Node?
    
    // -MARK: SETUP
    public func setup(graphViewContextMenuDelegate: GraphContextMenuInteractionDelegate, nodeDelegate: NodeDelegate) {
        self.graphViewContextMenuDelegate = graphViewContextMenuDelegate
        self.nodeDelegate = nodeDelegate
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
            if (key.modifierFlags == .command && key.characters == "i") || key.charactersIgnoringModifiers == UIKeyCommand.inputUpArrow {
                scrollView.scrollUp()
                didHandleEvent = true
            } else if (key.modifierFlags == .command && key.characters == "k") || key.charactersIgnoringModifiers == UIKeyCommand.inputDownArrow {
                scrollView.scrollDown()
                didHandleEvent = true
            } else if (key.modifierFlags == .command && key.characters == "j") || key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow{
                scrollView.scrollLeft()
                didHandleEvent = true
            } else if (key.modifierFlags == .command && key.characters == "l") || key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow {
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
    
    
    
    public func addNew(id: Int, contentType: ContentType) -> Node {
        let newNode = Node(id: id, parent: self.selectedNode, text: "")
        DispatchQueue.main.async {
            newNode.delegate = self.nodeDelegate
            self.graph.add(node: newNode.nodeParticle, parent: newNode.parent?.nodeParticle, contentType: contentType)
        }
        return newNode
    }
    
    public func add(node: Node, parent: Node? = nil, contentType: ContentType) {
        self.graph.add(node: node.nodeParticle, parent: parent?.nodeParticle, contentType: contentType)
//        self.select(node: node)
        
    }
    
    public func add(nodes: [Node]) {
        let nodeParticles = nodes.map { (node) -> NodeParticle in
            node.nodeParticle
        }
        self.graph.add(nodes: nodeParticles)
        
        nodes.filter { (node) -> Bool in
            node.parent != nil
        }.forEach { (node) in
            link(between: node.parent!, and: node)
        }
    }
    
    public func link(between from: Node, and to: Node) {
        self.graph.link(between: from.nodeParticle, and: to.nodeParticle)
    }
    
    public func focus(node: Node) {
        
        self.scrollView.scrollToView(view: node.nodeParticle.circleContainer, animated: true)
        self.select(node: node)
    }
    
    public func edit(node: Node) {
        let particle = node.nodeParticle
        switch particle?.circleContainer.contentType {
        case .text:
            let textView = particle?.circleContainer.content as! GraphTextNode
            textView.textView.becomeFirstResponder()
        case .none:
            break
        }
        
    }
    
    public func follow(node: Node?) {
        self.graph.followedNode = node?.nodeParticle
        if let node = node {
            self.graph.simulation.tickCallback = {
                self.scrollView.scrollToView(view: node.nodeParticle.circleContainer, animated: false)
            }
        }
    }
    
    public func select(node: Node) {
        if let selectedParticle = selectedNode?.nodeParticle {
            self.graph.deselect(nodeParticle: selectedParticle)
        }
        self.graph.select(nodeParticle: node.nodeParticle)
        selectedNode = node
        
    }
    
    public func delete(node: Node) {
        // delete from repository
        
        self.graph.delete(node: node.nodeParticle)
        
        if self.selectedNode == node {
            self.selectedNode = nil
        }
    }
    
}

extension GraphController {
    
    public func objectAtPoint(location: CGPoint) -> Node? {
        let nodeParticle = self.graph.objectAtPoint(location: location)
        return nodeParticle?.node
    }
}

