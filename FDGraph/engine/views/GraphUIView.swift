//
//  GraphUIView.swift
//  FDGraph
//
//  Created by Hevi on 17/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import SwiftUI

struct GraphUIView: UIViewControllerRepresentable {
    
    @ObservedObject var nodeStore = NodeStore()
    
    
    typealias UIViewControllerType = GraphController
    
    private let graphController = GraphController()
    private let graphContextMenuInteractionDelegate = GraphContextMenuInteractionDelegate()
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GraphUIView>) -> GraphController {
        
        self.nodeStore.nodes.append(contentsOf: [
            Node(id: 1, parent: nil, children: [], text: "Node 1", expanded: false, done: false, type: .text),
            Node(id: 2, parent: nil, children: [], text: "Node 2", expanded: false, done: false, type: .text),
            Node(id: 3, parent: nil, children: [], text: "Node 3", expanded: false, done: false, type: .text),
            Node(id: 4, parent: nil, children: [], text: "Node 4", expanded: false, done: false, type: .text),
            Node(id: 5, parent: nil, children: [], text: "Node 5", expanded: false, done: false, type: .text),
            Node(id: 6, parent: nil, children: [], text: "Node 6", expanded: false, done: false, type: .text),
            Node(id: 7, parent: nil, children: [], text: "Node 7", expanded: false, done: false, type: .text),
            Node(id: 8, parent: nil, children: [], text: "Node 8", expanded: false, done: false, type: .text),
            Node(id: 9, parent: nil, children: [], text: "Node 9", expanded: false, done: false, type: .text),
            Node(id: 10, parent: nil, children: [], text: "Node 10", expanded: false, done: false, type: .text),
            Node(id: 11, parent: nil, children: [], text: "Node 11", expanded: false, done: false, type: .text),
            Node(id: 12, parent: nil, children: [], text: "Node 12", expanded: false, done: false, type: .text),
            Node(id: 13, parent: nil, children: [], text: "Node 13", expanded: false, done: false, type: .text),
            Node(id: 14, parent: nil, children: [], text: "Node 14", expanded: false, done: false, type: .text),
            Node(id: 15, parent: nil, children: [], text: "Node 15", expanded: false, done: false, type: .text),
            Node(id: 16, parent: nil, children: [], text: "Node 16", expanded: false, done: false, type: .text),
            Node(id: 17, parent: nil, children: [], text: "Node 17", expanded: false, done: false, type: .text),
            Node(id: 18, parent: nil, children: [], text: "Node 18", expanded: false, done: false, type: .text),
            Node(id: 19, parent: nil, children: [], text: "Node 19", expanded: false, done: false, type: .text),
            Node(id: 20, parent: nil, children: [], text: "Node 20", expanded: false, done: false, type: .text),
            Node(id: 21, parent: nil, children: [], text: "Node 21", expanded: false, done: false, type: .text),
            Node(id: 22, parent: nil, children: [], text: "Node 22", expanded: false, done: false, type: .text),
            Node(id: 23, parent: nil, children: [], text: "Node 23", expanded: false, done: false, type: .text),
            Node(id: 24, parent: nil, children: [], text: "Node 24", expanded: false, done: false, type: .text),
            Node(id: 25, parent: nil, children: [], text: "Node 25", expanded: false, done: false, type: .text),
            Node(id: 26, parent: nil, children: [], text: "Node 26", expanded: false, done: false, type: .text),
            Node(id: 27, parent: nil, children: [], text: "Node 27", expanded: false, done: false, type: .text),
            Node(id: 28, parent: nil, children: [], text: "Node 28", expanded: false, done: false, type: .text),
            Node(id: 29, parent: nil, children: [], text: "Node 29", expanded: false, done: false, type: .text),
            Node(id: 30, parent: nil, children: [], text: "Node 30", expanded: false, done: false, type: .text),
            Node(id: 31, parent: nil, children: [], text: "Node 31", expanded: false, done: false, type: .text),
            Node(id: 32, parent: nil, children: [], text: "Node 32", expanded: false, done: false, type: .text),
            Node(id: 33, parent: nil, children: [], text: "Node 33", expanded: false, done: false, type: .text),
            Node(id: 34, parent: nil, children: [], text: "Node 34", expanded: false, done: false, type: .text),
            Node(id: 35, parent: nil, children: [], text: "Node 35", expanded: false, done: false, type: .text),
            Node(id: 36, parent: nil, children: [], text: "Node 36", expanded: false, done: false, type: .text),
            Node(id: 37, parent: nil, children: [], text: "Node 37", expanded: false, done: false, type: .text),
            Node(id: 38, parent: nil, children: [], text: "Node 38", expanded: false, done: false, type: .text),
            Node(id: 39, parent: nil, children: [], text: "Node 39", expanded: false, done: false, type: .text),
            Node(id: 40, parent: nil, children: [], text: "Node 40", expanded: false, done: false, type: .text),
            Node(id: 41, parent: nil, children: [], text: "Node 41", expanded: false, done: false, type: .text),
            Node(id: 42, parent: nil, children: [], text: "Node 42", expanded: false, done: false, type: .text),
            Node(id: 43, parent: nil, children: [], text: "Node 43", expanded: false, done: false, type: .text),
            Node(id: 44, parent: nil, children: [], text: "Node 44", expanded: false, done: false, type: .text),
            Node(id: 45, parent: nil, children: [], text: "Node 45", expanded: false, done: false, type: .text),
            Node(id: 46, parent: nil, children: [], text: "Node 46", expanded: false, done: false, type: .text),
            Node(id: 47, parent: nil, children: [], text: "Node 47", expanded: false, done: false, type: .text),
            Node(id: 48, parent: nil, children: [], text: "Node 48", expanded: false, done: false, type: .text),
            Node(id: 49, parent: nil, children: [], text: "Node 49", expanded: false, done: false, type: .text),
            Node(id: 50, parent: nil, children: [], text: "Node 50", expanded: false, done: false, type: .text),
        ])
        
        self.graphContextMenuInteractionDelegate.setup(graphController: self.graphController)
        self.graphController.setup(graphViewContextMenuDelegate: graphContextMenuInteractionDelegate, nodeDelegate: context.coordinator)
        
        
        
        
        return self.graphController
    }
    
    func updateUIViewController(_ uiViewController: GraphController, context: UIViewControllerRepresentableContext<GraphUIView>) {
        
        self.nodeStore.nodes.forEach { (node) in
            node.delegate = context.coordinator
        }
        
        self.nodeStore.nodes[1].parent = self.nodeStore.nodes[0]
        self.nodeStore.nodes[2].parent = self.nodeStore.nodes[0]
        self.nodeStore.nodes[3].parent = self.nodeStore.nodes[0]
        self.nodeStore.nodes[4].parent = self.nodeStore.nodes[0]
        self.nodeStore.nodes[5].parent = self.nodeStore.nodes[0]
        
        self.nodeStore.nodes[0].parent = self.nodeStore.nodes[6]
        
        self.nodeStore.nodes[1].parent = self.nodeStore.nodes[7]
        self.nodeStore.nodes[8].parent = self.nodeStore.nodes[7]
        self.nodeStore.nodes[9].parent = self.nodeStore.nodes[7]
        self.nodeStore.nodes[10].parent = self.nodeStore.nodes[7]
        self.nodeStore.nodes[11].parent = self.nodeStore.nodes[7]
        
        self.nodeStore.nodes[12].parent = self.nodeStore.nodes[8]
        self.nodeStore.nodes[13].parent = self.nodeStore.nodes[8]
        self.nodeStore.nodes[14].parent = self.nodeStore.nodes[8]
        self.nodeStore.nodes[15].parent = self.nodeStore.nodes[8]
        self.nodeStore.nodes[16].parent = self.nodeStore.nodes[8]
        self.nodeStore.nodes[17].parent = self.nodeStore.nodes[8]
        self.nodeStore.nodes[18].parent = self.nodeStore.nodes[8]
        self.nodeStore.nodes[19].parent = self.nodeStore.nodes[8]
        
        self.nodeStore.nodes[14].parent = self.nodeStore.nodes[9]
        self.nodeStore.nodes[15].parent = self.nodeStore.nodes[9]
        self.nodeStore.nodes[16].parent = self.nodeStore.nodes[9]
        self.nodeStore.nodes[17].parent = self.nodeStore.nodes[9]
        
        
        
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

class NodeStore: ObservableObject {
    var nodes: [Node] = []
}
