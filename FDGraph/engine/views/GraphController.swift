//
//  GraphController.swift
//  ForceDirectedNew
//
//  Created by Hevi on 13/03/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

public protocol GraphDelegate {
    
    func handleAddChild()
    func handleAddSibling()
}

// -MARK: DECLARATIONS
class GraphController: UIViewController {
    
    public static let GRAPH_CANVAS_SIZE: CGFloat = 50000
    
    var allNodes: [Node] = []
    
    private var graphViewContextMenuDelegate: GraphContextMenuInteractionDelegate!
    private var nodeDelegate: NodeDelegate!
    private var graphDelegate: GraphDelegate!
    
    private lazy var scrollView: GraphScrollView = {
        let view = GraphScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = GraphController.GRAPH_CANVAS_SIZE
        view.contentSize.width = GraphController.GRAPH_CANVAS_SIZE
        view.frame = self.view.frame
        return view
    }()
    
    lazy var graphView: GraphView = {
        return GraphView(width: GraphController.GRAPH_CANVAS_SIZE, height: GraphController.GRAPH_CANVAS_SIZE)
    }()
    
    lazy var graph: GraphEngine = {
        let graphEngine = GraphEngine(containerView: self.graphView)
        return graphEngine
    }()
    
    private var _selectedNode: Node?
    public var selectedNode: Node? {
        set {
            self._selectedNode = newValue
            self.graph.selectedNode = newValue
        }
        get {
            return _selectedNode
        }
    }
    
    private var isEditMode: Bool = false
    
    // -MARK: SETUP
    public func setup(graphViewContextMenuDelegate: GraphContextMenuInteractionDelegate, nodeDelegate: NodeDelegate, graphDelegate: GraphDelegate) {
        self.graphViewContextMenuDelegate = graphViewContextMenuDelegate
        self.nodeDelegate = nodeDelegate
        self.graphDelegate = graphDelegate
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
    
    // -MARK: pressesBegan
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        var didHandleEvent = false
        for press in presses {
            guard let key = press.key else { continue }
            
            //            if self.isFirstResponder {
            
            if !self.isEditMode {
            
                didHandleEvent = handleGraphMoving(key: key)
                
                if !didHandleEvent {
                    didHandleEvent = handleNodeSelection(key: key)
                }
                
                if !didHandleEvent {
                    didHandleEvent = handleNodeAddition(key: key)
                }
                
                if !didHandleEvent {
                    if key.characters == "u" {
                        scrollView.zoomIn()
                        didHandleEvent = true
                    } else if key.characters == "o" {
                        scrollView.zoomOut()
                        didHandleEvent = true
                    }
                }
            }
        }
        
        if didHandleEvent == false {
            // Didn't handle this key press, so pass the event to the next responder.
            super.pressesBegan(presses, with: event)
        }
        
    }
    
    private func handleGraphMoving(key: UIKey) -> Bool {
        if (key.modifierFlags == .command && key.characters == "i") || key.charactersIgnoringModifiers == UIKeyCommand.inputUpArrow {
            scrollView.scrollUp()
            return true
        } else if (key.modifierFlags == .command && key.characters == "k") || key.charactersIgnoringModifiers == UIKeyCommand.inputDownArrow {
            scrollView.scrollDown()
            return true
        } else if (key.modifierFlags == .command && key.characters == "j") || key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow{
            scrollView.scrollLeft()
            return true
        } else if (key.modifierFlags == .command && key.characters == "l") || key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow {
            scrollView.scrollRight()
            return true
        }
        return false
    }
    
    private func handleNodeSelection(key: UIKey) -> Bool {
        if (key.modifierFlags == .shift && key.charactersIgnoringModifiers == "i") {
            self.selectBelow(nodesInTree: false)
            return true
        } else if (key.modifierFlags == .shift && key.charactersIgnoringModifiers == "k") {
            self.selectAbove(nodesInTree: false)
            return true
        } else if (key.modifierFlags == .shift && key.charactersIgnoringModifiers == "j") {
            self.selectLeft(nodesInTree: false)
            return true
        } else if (key.modifierFlags == .shift && key.charactersIgnoringModifiers == "l") {
            self.selectRight(nodesInTree: false)
            return true
        } else if (key.modifierFlags != .command && key.characters == "i") || key.charactersIgnoringModifiers == UIKeyCommand.inputUpArrow {
            self.selectBelow(nodesInTree: true)
            return true
        } else if (key.modifierFlags != .command && key.characters == "k") || key.charactersIgnoringModifiers == UIKeyCommand.inputDownArrow {
            self.selectAbove(nodesInTree: true)
            return true
        } else if (key.modifierFlags != .command && key.characters == "j") || key.charactersIgnoringModifiers == UIKeyCommand.inputLeftArrow {
            self.selectLeft(nodesInTree: true)
            return true
        } else if (key.modifierFlags != .command && key.characters == "l") || key.charactersIgnoringModifiers == UIKeyCommand.inputRightArrow {
            self.selectRight(nodesInTree: true)
            return true
        }
        return false
    }
    
    private func handleNodeAddition(key: UIKey) -> Bool {
        if key.modifierFlags != .shift && key.characters == "\r" {
            self.graphDelegate.handleAddChild()
            return true
        } else if key.modifierFlags == .shift && key.characters == "\r" {
            self.graphDelegate.handleAddSibling()
            return true
        }
        return false
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
    
    public func add(node: Node, contentType: ContentType) {
        node.delegate = self.nodeDelegate
        
        if let root = node.root {
            graph.setCenter(to: root.nodeParticle)
            
            let childParticles = root.childNodesInTree.map { (node) -> NodeParticle in
                node.nodeParticle
            }
            self.graph.setParticles(particles: childParticles)
        }
        
        self.graph.add(node: node.nodeParticle, parent: node.parent?.nodeParticle, contentType: contentType)
    }
    
    
    
    public func add(nodes: [Node]) {
        allNodes = nodes
        
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
    }
    
    public func edit(node: Node) {
        let particle = node.nodeParticle
        switch particle?.circleContainer.contentType {
        case .text:
            let textView = particle?.circleContainer.content as! GraphTextNode
            textView.textView.becomeFirstResponder()
            self.isEditMode = true
        case .none:
            break
        }
    }
    
    public func endEdit(node: Node) {
        self.isEditMode = false
    }
    
    public func follow(node: Node?) {
        self.graph.followedNode = node?.nodeParticle
        if let node = node {
            self.graph.simulation.tickCallback = {
                self.scrollView.scrollToView(view: node.nodeParticle.circleContainer, animated: false)
            }
        }
    }
    
    private func preSelectNextChild() {
        guard let selectedNode = selectedNode else { return }
        let children = selectedNode.children
        
        print("preSelectNextChild")
        
        
        if let preSelectedChild = selectedNode.preSelectedChild,
           let preSelectedChildIndex = children.firstIndex(of: preSelectedChild),
           children.count > preSelectedChildIndex + 1 {
            let nextSelectedNode = children[preSelectedChildIndex + 1]
            preSelect(node: nextSelectedNode)
        } else if children.count > 0 {
            let nextSelectedNode = children[0]
            preSelect(node: nextSelectedNode)
        }
    }
    
    private func preSelectPreviousChild() {
        guard let selectedNode = selectedNode else { return }
        let children = selectedNode.children
        
        print("preSelectPreviousChild")
        
        
        if let preSelectedChild = selectedNode.preSelectedChild,
           let preSelectedChildIndex = children.firstIndex(of: preSelectedChild),
            preSelectedChildIndex - 1 >= 0 {
            let prevSelectedNode = children[preSelectedChildIndex - 1]
            preSelect(node: prevSelectedNode)
        } else if children.count > 0 {
            let prevSelectedNode = children[children.count - 1]
            preSelect(node: prevSelectedNode)
        }
    }
    
    private func selectNextSibling() {
        guard let selectedNode = selectedNode else { return }
        guard let siblings = selectedNode.parent?.children else { return }
        guard let indexOfSelectedNode = siblings.firstIndex(of: selectedNode) else { return }
        print("selectNextSibling")
        
        let indexOfNextSelectedNode = indexOfSelectedNode + 1
        if siblings.count > indexOfNextSelectedNode {
            let nextSelectedNode = siblings[indexOfNextSelectedNode]
            select(node: nextSelectedNode)
        }
    }
    
    private func selectPreviousSibling() {
        guard let selectedNode = selectedNode else { return }
        guard let siblings = selectedNode.parent?.children else { return }
        guard let indexOfSelectedNode = siblings.firstIndex(of: selectedNode) else { return }
        print("selectPreviousSibling")
        
        let indexOfNextSelectedNode = indexOfSelectedNode - 1
        
        if indexOfNextSelectedNode >= 0 {
            select(node: siblings[indexOfNextSelectedNode])
        } else {
            select(node: siblings[siblings.count - 1])
        }
    }
    
    private func selectParent() {
        guard let selectedNode = selectedNode else { return }
        guard let parent = selectedNode.parent else { return }
        print("selectParent")
        
        select(node: parent)
    }
    
    private func selectChild() {
        guard let selectedNode = selectedNode else { return }
        guard selectedNode.children.count > 0 else { return }
        print("selectChild")
        
        let selectedChild = selectedNode.preSelectedChild ?? selectedNode.lastSelectedChild ?? selectedNode.children[0]
        
        select(node: selectedChild)
    }
    
    public func preSelect(node: Node) {
        node.parent?.preSelectedChild = node
        self.graph.preSelect()
    }
    
    public func select(node: Node) {
        if let selectedNode = selectedNode {
            deselect(node: selectedNode)
        }
        
        selectedNode = node
        
        selectedNode!.parent?.lastSelectedChild = selectedNode!
        selectedNode!.parent?.preSelectedChild = selectedNode!

        self.graph.select(nodeParticle: selectedNode!.nodeParticle)
    }
    
    public func deselect(node: Node) {
        selectedNode = nil
        
        if let nodeParticle = node.nodeParticle {
            self.graph.deselect(nodeParticle: nodeParticle)
        }
    }

    public func delete(node: Node) {
        // TODO: delete from repository
        
        if let root = node.root {
            graph.setCenter(to: root.nodeParticle)
            
            let childParticles = root.childNodesInTree.map { (node) -> NodeParticle in
                node.nodeParticle
            }
            self.graph.setParticles(particles: childParticles)
        }
        
        self.graph.delete(node: node.nodeParticle)
        
        if self.selectedNode == node {
            self.selectedNode = nil
        }
    }
    
    public func pin(node: Node) {
        node.fixed = true
    }
    
    public func unpin(node: Node) {
        node.fixed = false
        self.graph.simulation.kick()
    }
    
    
    // TEMP
    
    func selectAbove(nodesInTree: Bool) {
        guard let selectedNode = selectedNode else { return }
        
        let allNodesInTree = selectedNode.root?.childNodesInTree

        var pointsAbove: [Node] = []
        if nodesInTree {
            pointsAbove = graph.determinePointsAbove(points: allNodesInTree)
        } else {
            pointsAbove = graph.determinePointsAbove()
        }
        
        if let closestAbove = graph.determineClosest(center: selectedNode, points: pointsAbove) {
            select(node: closestAbove)
            focus(node: closestAbove)
        }
    }
    
    func selectBelow(nodesInTree: Bool) {
        guard let selectedNode = selectedNode else { return }
        
        let allNodesInTree = selectedNode.root?.childNodesInTree
        
        var pointsBelow: [Node] = []
        if nodesInTree {
            pointsBelow = graph.determinePointsBelow(points: allNodesInTree)
        } else {
            pointsBelow = graph.determinePointsBelow()
        }
        
        if let closestBelow = graph.determineClosest(center: selectedNode, points: pointsBelow) {
            select(node: closestBelow)
            focus(node: closestBelow)
        }
    }
    
    func selectLeft(nodesInTree: Bool) {
        guard let selectedNode = selectedNode else { return }
        
        let allNodesInTree = selectedNode.root?.childNodesInTree
        
        var pointsLeft: [Node] = []
        if nodesInTree {
            pointsLeft = graph.determinePointsLeft(points: allNodesInTree)
        } else {
            pointsLeft = graph.determinePointsLeft()
        }
        
        if let closestLeft = graph.determineClosest(center: selectedNode, points: pointsLeft) {
            select(node: closestLeft)
            focus(node: closestLeft)
        }
    }
    
    func selectRight(nodesInTree: Bool) {
        guard let selectedNode = selectedNode else { return }
        
        let allNodesInTree = selectedNode.root?.childNodesInTree
        
        var pointsRight: [Node] = []
        if nodesInTree {
            pointsRight = graph.determinePointsRight(points: allNodesInTree)
        } else {
            pointsRight = graph.determinePointsRight()
        }
        
        if let closestRight = graph.determineClosest(center: selectedNode, points: pointsRight) {
            select(node: closestRight)
            focus(node: closestRight)
        }
    }
    
}

extension GraphController {
    
    public func objectAtPoint(location: CGPoint) -> Node? {
        let nodeParticle = self.graph.objectAtPoint(location: location)
        return nodeParticle?.node
    }
}

