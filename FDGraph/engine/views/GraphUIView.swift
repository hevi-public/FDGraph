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
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.2, contentType: .text),
        Node(radiusMultiplier: 1.2, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.4, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.5, contentType: .text),
        Node(radiusMultiplier: 1.4, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.6, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.2, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.7, contentType: .text),
        Node(radiusMultiplier: 1.3, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.8, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.5, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.6, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.5, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text),
        Node(radiusMultiplier: 1.0, contentType: .text)
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
    class Coordinator: NSObject, NodeParticleDelegate {
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
            self.parent.graphController.focus(node: node)
        }
    }
    
    func deletedNode(node: Node) {
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
    func makeContextMenuForNode(node: Node, graphController: GraphController) -> UIMenu {
        
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
