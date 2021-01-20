//
//  GraphUIView.swift
//  FDGraph
//
//  Created by Hevi on 17/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import SwiftUI

struct GraphUIView: UIViewControllerRepresentable {
    
//    let nodeStore = DummyDataStore()
    let jsonStore = JsonFileBasedDataStore()
    
    typealias UIViewControllerType = GraphController
    
    private let graphController = GraphController()
    private let graphContextMenuInteractionDelegate = GraphContextMenuInteractionDelegate()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GraphUIView>) -> GraphController {
        
        self.graphContextMenuInteractionDelegate.setup(uiView: self,
                                                       graphController: self.graphController)
        
        self.graphController.setup(graphViewContextMenuDelegate: graphContextMenuInteractionDelegate,
                                   nodeDelegate: context.coordinator,
                                   graphDelegate: context.coordinator,
                                   simulationDelegate: self)
        
//        let allNodes = self.nodeStore.fetchAll()
        let allNodes = initNodes(delegate: context.coordinator)
        
        graphController.add(nodes: allNodes,
                             addToForceParticles: false)
        
        
        return self.graphController
    }
    
    func updateUIViewController(_ uiViewController: GraphController, context: UIViewControllerRepresentableContext<GraphUIView>) {
        

    }
    
    private func initNodes(delegate: NodeDelegate) -> [Node] {
        let allNodes = self.jsonStore.fetchAll()
        
        allNodes.forEach { (node) in
            node.delegate = delegate
        }
        
        return allNodes
    }
    
    // -MARK: COORDINATOR
    class Coordinator: NSObject, NodeDelegate, GraphDelegate {
        
        var uiView: GraphUIView
        
        var graphController: GraphController {
            get {
                uiView.graphController
            }
        }
        
        init(_ uiView: GraphUIView) {
            self.uiView = uiView
        }
        
        // -MARK: NodeDelegate
        
        func handleSingleTap(node: Node) {
            graphController.select(node: node)
        }
        
        func handleDoubleTap(node: Node) {
            //            let newNode = Node(radius: GraphUIView.radius)
            //            newNode.delegate = self
            //            self.parent.graphController.add(node: newNode, parent: node)
            //            self.parent.graphController.focus(node: newNode)
            graphController.edit(node: node)
        }
        
        func handleDragged(node: Node, gestureRecognizer: UIGestureRecognizer) {
            guard let particle = node.nodeParticle,
                  node == graphController.selectedNode else { return }
            
            switch gestureRecognizer.state {
            case .began:
                particle.node.fixed = true
                if let root = node.root {
                    let childParticles = root.childNodesInTree.map { (node) -> NodeParticle in
                        node.nodeParticle
                    }
                    graphController.unfollow()
                    graphController.graph.setParticles(particles: childParticles)
                }
            case .changed:
                particle.position = gestureRecognizer.location(in: graphController.graphView)
                self.graphController.graph.simulation.kick()
//            case .cancelled, .ended:
            default:
                break
            }
            self.graphController.graph.simulation.allParticles.update(with: particle)
            self.graphController.graph.simulation.forceParticles.update(with: particle)
        }
        
        // -MARK: GraphDelegate
        
        func handleAddChild() {
            uiView.handleAddChild()
        }
        
        func handleAddSibling() {
            uiView.handleAddSibling()
        }
        
        func save(node: Node) {
            uiView.save(node: node)
            graphController.endEdit(node: node)
        }
        
        func delete(node: Node) {
            uiView.jsonStore.remove(node: node)
        }
    }
    
    func handleAddRoot(position: CGPoint) {
        let maxId = self.jsonStore.getMaxId() ?? 0
        
        let newNode = Node(id: maxId + 1, parent: nil, text: "", fixed: true, position: position)
        
//        nodeStore.add(node: newNode)
        jsonStore.add(node: newNode)
        
        graphController.add(node: newNode, contentType: .text)
        graphController.select(node: newNode)
        graphController.edit(node: newNode)
    }
    
    func handleAddChild() {
        guard let selectedNode = graphController.selectedNode else { return }
        
        let maxId = self.jsonStore.getMaxId() ?? 0
        
        let newNode = Node(id: maxId + 1, parent: selectedNode, text: "")
        
//        nodeStore.add(node: newNode)
        jsonStore.add(node: newNode)
        
        graphController.add(node: newNode, contentType: .text)
        graphController.select(node: newNode)
        graphController.edit(node: newNode)
    }
    
    func handleAddSibling() {
        guard let selectedNode = graphController.selectedNode else { return }
        guard let parent = selectedNode.parent else { return }
        
        let maxId = self.jsonStore.getMaxId() ?? 0
        
        let newNode = Node(id: maxId + 1, parent: parent, text: "")
        
//        nodeStore.add(node: newNode)
        jsonStore.add(node: newNode)
        
        graphController.add(node: newNode, contentType: .text)
        graphController.select(node: newNode)
        graphController.edit(node: newNode)
    }
    
    func save(node: Node) {
//        nodeStore.update(node: node)
        jsonStore.update(node: node)
    }
    
    func addChildToSelectedNode() {
        let maxId = self.jsonStore.getMaxId()
        
        let newNode = self.graphController.addNew(id: (maxId ?? 0) + 1, contentType: .text)
//        self.nodeStore.add(node: newNode)
        self.jsonStore.add(node: newNode)
    
    }
    
    func deletedNode(node: Node) {
        self.graphController.delete(node: node)
    }
    
}

extension GraphUIView: SimulationDelegate {
    func simulationStop() {
        print("simulation Stop in Delegate")
        
        graphController.graph.simulation.forceParticles.forEach { (particle) in
            let node = particle.node
            jsonStore.update(node: node)
        }
    }
}


// -MARK: CONTEXT MENU
class GraphContextMenuInteractionDelegate: NSObject, UIContextMenuInteractionDelegate {
    
    private unowned var graphController: GraphController!
    private var uiView: GraphUIView! // FIX look into how to remove this reference
    
    func setup(uiView: GraphUIView,
               graphController: GraphController) {
        self.uiView = uiView
        self.graphController = graphController
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        if let clickedNode = self.graphController.objectAtPoint(location: location) {
            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
                return self.makeContextMenuForNode(node: clickedNode, graphController: self.graphController)
            })
        } else {
            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
                return self.makeContextMenuForCanvas(location: location)
            })
            
        }
    }
    
    // -MARK: CONTEXT FOR CANVAS
    func makeContextMenuForCanvas(location: CGPoint) -> UIMenu {
        
        let add = UIAction(title: "Add new root node", image: UIImage(systemName: "plus.circle")) { action in
            self.uiView.handleAddRoot(position: location)
        }
        
        return UIMenu(title: "Main Menu", children: [add])
    }
    
    // -MARK: CONTEXT FOR NODE
    func makeContextMenuForNode(node: Node, graphController: GraphController) -> UIMenu {
        
        var children = [UIAction]()
        
        if let selectedNode = graphController.selectedNode,
            selectedNode != node {
            let linkNode = UIAction(title: "Link", image: UIImage(systemName: "square.and.arrow.up")) { action in
                graphController.link(between: selectedNode, and: node)
            }
            children.append(linkNode)
        }
        
        
        if node.fixed {
            let unPin = UIAction(title: "Unpin", image: UIImage(systemName: "pin.slash")) { action in
                graphController.unpin(node: node)
                self.uiView.save(node: node)
            }
            children.append(unPin)
        } else {
            let pin = UIAction(title: "Pin", image: UIImage(systemName: "pin.slash")) { action in
                graphController.pin(node: node)
                self.uiView.save(node: node)
            }
            children.append(pin)
        }
        
        
        let deleteNode = UIAction(title: "Delete", image: UIImage(systemName: "square.and.arrow.up")) { action in
            graphController.delete(node: node)
        }
        children.append(deleteNode)
        
        return UIMenu(title: "Main Menu", children: children)
    }
}
