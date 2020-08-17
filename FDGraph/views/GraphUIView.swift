//
//  GraphUIView.swift
//  FDGraph
//
//  Created by Hevi on 17/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import SwiftUI

struct GraphUIView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = GraphController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GraphUIView>) -> GraphController {
        let graphController = GraphController()
        
        let radius = CGFloat(10)
        
        let nodes = [
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius * 1.1)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius * 1.4)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius * 1.2)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius * 1.3)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius * 1.1)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius * 1.5)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius * 1.6)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius * 1.5)),
            Node(view: Circle.createCircle(radius: radius)),
            Node(view: Circle.createCircle(radius: radius))
        ]
        
        graphController.add(nodes: nodes)
        graphController.add(edges: [])
        
        return graphController
    }
    
    func updateUIViewController(_ uiViewController: GraphController, context: UIViewControllerRepresentableContext<GraphUIView>) {
        
    }
}
