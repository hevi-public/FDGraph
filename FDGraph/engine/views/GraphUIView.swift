//
//  GraphUIView.swift
//  FDGraph
//
//  Created by Hevi on 17/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import SwiftUI

struct GraphUIView: UIViewControllerRepresentable {
    
    let nodeStore = DummyDataStore()
    
    
    typealias UIViewControllerType = GraphController
    
    private let graphController = GraphController()
    private let graphContextMenuInteractionDelegate = GraphContextMenuInteractionDelegate()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GraphUIView>) -> GraphController {
        
        self.graphContextMenuInteractionDelegate.setup(graphController: self.graphController)
        self.graphController.setup(graphViewContextMenuDelegate: graphContextMenuInteractionDelegate,
                                   nodeDelegate: context.coordinator,
                                   graphDelegate: context.coordinator)
        
        
        
        
        return self.graphController
    }
    
    func updateUIViewController(_ uiViewController: GraphController, context: UIViewControllerRepresentableContext<GraphUIView>) {
        
        let allNodes = self.nodeStore.fetchAll()
        
        allNodes.forEach { (node) in
            node.delegate = context.coordinator
        }
        
        uiViewController.add(nodes: allNodes)
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
        
        // -MARK: GraphDelegate
        
        func handleAddChild() {
            uiView.handleAddChild()
        }
        
        func handleAddSibling() {
            uiView.handleAddSibling()
        }
        
        func save(node: Node) {
            uiView.save(node: node)
        }
        
    }
    
    func handleAddChild() {
        guard let selectedNode = graphController.selectedNode else { return }
        
        let maxId = getMaxId() ?? 0
        
        let newNode = Node(id: maxId + 1, parent: selectedNode, text: "")
        
        nodeStore.add(node: newNode)
        
        graphController.add(node: newNode, contentType: .text)
        graphController.select(node: newNode)
        graphController.edit(node: newNode)
    }
    
    func handleAddSibling() {
        guard let selectedNode = graphController.selectedNode else { return }
        guard let parent = selectedNode.parent else { return }
        
        let maxId = getMaxId() ?? 0
        
        let newNode = Node(id: maxId + 1, parent: parent, text: "")
        
        nodeStore.add(node: newNode)
        
        graphController.add(node: newNode, contentType: .text)
        graphController.select(node: newNode)
        graphController.edit(node: newNode)
    }
    
    func save(node: Node) {
        nodeStore.update(node: node)
    }
    
    private func getMaxId() -> Int? {
        let nodeWithMaxId = self.nodeStore.fetchAll().filter({ node -> Bool in
            node.id != nil
        }).max { (a, b) -> Bool in
            a.id! < b.id!
        }
        
        return nodeWithMaxId?.id
    }
    
    func addChildToSelectedNode() {
        let maxId = getMaxId()
        
        let newNode = self.graphController.addNew(id: (maxId ?? 0) + 1, contentType: .text)
        self.nodeStore.add(node: newNode)
    
    }
    
    func deletedNode(node: Node) {
        self.graphController.delete(node: node)
    }
    
}


// -MARK: CONTEXT MENU
class GraphContextMenuInteractionDelegate: NSObject, UIContextMenuInteractionDelegate {
    
    private unowned var graphController: GraphController!
    
    func setup(graphController: GraphController) {
        self.graphController = graphController
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        if let clickedNode = self.graphController.objectAtPoint(location: location) {
            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
                return self.makeContextMenuForNode(node: clickedNode, graphController: self.graphController)
            })
        } else {
            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in
                return self.makeContextMenuForCanvas()
            })
            
        }
    }
    
    // -MARK: CONTEXT FOR CANVAS
    func makeContextMenuForCanvas() -> UIMenu {
        
        let share = UIAction(title: "makeContextMenuForCanvas", image: UIImage(systemName: "square.and.arrow.up")) { action in
            
        }
        
        return UIMenu(title: "Main Menu", children: [share])
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
        
        let deleteNode = UIAction(title: "Delete", image: UIImage(systemName: "square.and.arrow.up")) { action in
            graphController.delete(node: node)
        }
        children.append(deleteNode)
        
        return UIMenu(title: "Main Menu", children: children)
    }
}
