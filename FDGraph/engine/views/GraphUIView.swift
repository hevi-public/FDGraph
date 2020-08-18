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
    
    class Coordinator: NSObject, NodeParticleDelegate {
        
        var parent: GraphUIView
        
        init(_ parent: GraphUIView) {
            self.parent = parent
        }
        
        func handleTap(node: Node) {
            print("taaaaaap")
            self.parent.graphController.focus(node: node)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GraphUIView>) -> GraphController {
        
        
        return self.graphController
    }
    
    func updateUIViewController(_ uiViewController: GraphController, context: UIViewControllerRepresentableContext<GraphUIView>) {
//
//        nodes.forEach(node -> {
//            node.delegate = self
//        })
        
        nodes.forEach { (node) in
            node.delegate = context.coordinator
        }
        
        uiViewController.add(nodes: nodes)
        uiViewController.add(edges: [])
        
    }
}
