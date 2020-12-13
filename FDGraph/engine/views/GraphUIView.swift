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
        self.graphController.setup(graphViewContextMenuDelegate: graphContextMenuInteractionDelegate, nodeDelegate: context.coordinator)
        
        
        
        
        return self.graphController
    }
    
    func updateUIViewController(_ uiViewController: GraphController, context: UIViewControllerRepresentableContext<GraphUIView>) {
        
        self.nodeStore.nodes.forEach { (node) in
            node.delegate = context.coordinator
        }
        
        uiViewController.add(nodes: self.nodeStore.nodes)
    }
    
    // -MARK: COORDINATOR
    class Coordinator: NSObject, NodeDelegate {
        var parent: GraphUIView
        
        init(_ parent: GraphUIView) {
            self.parent = parent
        }
        
        func handleSingleTap(node: Node) {
            self.parent.graphController.select(node: node)
        }
        
        func handleDoubleTap(node: Node) {
            //            let newNode = Node(radius: GraphUIView.radius)
            //            newNode.delegate = self
            //            self.parent.graphController.add(node: newNode, parent: node)
            //            self.parent.graphController.focus(node: newNode)
            self.parent.graphController.edit(node: node)
        }
    }
    
    func addChildToSelectedNode() {
        
        let nodeWithMaxId = self.nodeStore.nodes.filter({ node -> Bool in
            node.id != nil
        }).max { (a, b) -> Bool in
            a.id! < b.id!
        }
        
        
        let newNode = self.graphController.addNew(id: (nodeWithMaxId?.id ?? 0) + 1, contentType: .text)
        self.nodeStore.nodes.append(newNode)
        print(self.nodeStore.nodes.count)
    
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
