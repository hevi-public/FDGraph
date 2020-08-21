//
//  GraphUIView.swift
//  FDGraph
//
//  Created by Hevi on 17/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import SwiftUI

struct GraphUIView: UIViewControllerRepresentable {
    
    static let radius = CGFloat(10)
    
    @State var nodes: [Node] = [
        Node(radius: radius),
        Node(radius: radius * 1.1),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.4),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.2),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.3),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.1),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.5),
        Node(radius: radius),
        Node(radius: radius * 1.6),
        Node(radius: radius),
        Node(radius: radius * 1.5),
        Node(radius: radius),
        Node(radius: radius)
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
    
    class Coordinator: NSObject, NodeParticleDelegate {
        var parent: GraphUIView
        
        init(_ parent: GraphUIView) {
            self.parent = parent
        }
        
        func handleSingleTap(node: Node) {
            print("taaaaaap")
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
    
    func deleteSelectedNodes() {
        self.graphController.deleteSelectedNodes()
    }
}



class GraphContextMenuInteractionDelegate: NSObject, UIContextMenuInteractionDelegate {
    
    private unowned var graphController: GraphController!
    
    func setup(graphController: GraphController) {
        self.graphController = graphController
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil, actionProvider: { suggestedActions in

            if let clickedNode = self.graphController.objectAtPoint(location: location) {
                return self.makeContextMenuForNode()
            } else {
                return self.makeContextMenuForCanvas()
            }
        })
    }
    
    func makeContextMenuForCanvas() -> UIMenu {

        // Create a UIAction for sharing
        let share = UIAction(title: "makeContextMenuForCanvas", image: UIImage(systemName: "square.and.arrow.up")) { action in
            // Show system share sheet
        }

        // Create and return a UIMenu with the share action
        return UIMenu(title: "Main Menu", children: [share])
    }
    
    func makeContextMenuForNode() -> UIMenu {

        // Create a UIAction for sharing
        let share = UIAction(title: "makeContextMenuForNode", image: UIImage(systemName: "square.and.arrow.up")) { action in
            // Show system share sheet
        }

        // Create and return a UIMenu with the share action
        return UIMenu(title: "Main Menu", children: [share])
    }
}
