//
//  GraphUIView.swift
//  FDGraph
//
//  Created by Hevi on 17/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import SwiftUI

struct GraphUIView: UIViewControllerRepresentable {
    
    @State var nodes: [Node] = [
        Node(id: 1, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 2, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 3, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 4, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 5, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 6, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 7, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 8, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 9, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 10, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 11, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 12, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 13, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 14, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 15, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 16, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 17, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 18, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 19, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 20, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 21, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 22, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 23, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 24, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 25, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 26, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 27, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 28, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 29, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 30, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 31, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 32, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 33, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 34, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 35, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 36, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 37, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 38, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 39, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 40, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 41, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 42, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 43, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 44, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 45, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 46, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 47, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 48, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 49, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
        Node(id: 50, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
    ]
    
    typealias UIViewControllerType = GraphController
    
    private let graphController = GraphController()
    private let graphContextMenuInteractionDelegate = GraphContextMenuInteractionDelegate()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GraphUIView>) -> GraphController {
        self.graphContextMenuInteractionDelegate.setup(graphController: self.graphController)
        self.graphController.setup(graphViewContextMenuDelegate: graphContextMenuInteractionDelegate)
        
        
        return self.graphController
    }
    
    func updateUIViewController(_ uiViewController: GraphController, context: UIViewControllerRepresentableContext<GraphUIView>) {
        
        nodes.forEach { (node) in
            node.delegate = context.coordinator
        }
        
        uiViewController.add(nodes: nodes)
        uiViewController.add(edges: [])
        
    }
    
    // -MARK: COORDINATOR
    class Coordinator: NSObject, NodeDelegate {
        var parent: GraphUIView
        
        init(_ parent: GraphUIView) {
            self.parent = parent
        }
        
        func handleSingleTap(node: NodeParticle) {
            self.parent.graphController.select(node: node)
        }
        
        func handleDoubleTap(node: NodeParticle) {
            //            let newNode = Node(radius: GraphUIView.radius)
            //            newNode.delegate = self
            //            self.parent.graphController.add(node: newNode, parent: node)
            //            self.parent.graphController.focus(node: newNode)
            self.parent.graphController.edit(node: node)
        }
    }
    
    func deletedNode(node: NodeParticle) {
        self.graphController.delete(node: node)
    }
    
    func deleteSelectedNodes() {
        self.graphController.deleteSelectedNodes()
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
    func makeContextMenuForNode(node: NodeParticle, graphController: GraphController) -> UIMenu {
        
        var children = [UIAction]()
        
        if let selectedNode = graphController.selectedNode(),
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
