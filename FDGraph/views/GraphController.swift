//
//  GraphController.swift
//  ForceDirectedNew
//
//  Created by Hevi on 13/03/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class GraphController: UIViewController {
    
    public static let GRAPH_CANVAS_SIZE: CGFloat = 50000
    
    private lazy var scrollView: GraphScrollView = {
        let view = GraphScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = GraphController.GRAPH_CANVAS_SIZE
        view.contentSize.width = GraphController.GRAPH_CANVAS_SIZE
        view.frame = self.view.frame
        return view
    }()
    
    private var graphView: GraphView!
    
    override func viewDidLoad() {
        print("GraphController viewDidLoad")
        
        let mass = CGFloat(100)
        let radius = CGFloat(10)
        
        let nodes = [
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius * 1.1)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius * 1.4)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius * 1.2)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius * 1.3)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius * 1.1)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius * 1.5)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius * 1.6)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius * 1.5)),
            Node(mass: mass, view: Circle.createCircle(radius: radius)),
            Node(mass: mass, view: Circle.createCircle(radius: radius))
        ]
        
        
        
        let edges: [Edge] = [
            
//            Edge(to: node[0], from: node[1]),
//            Edge(to: node[2], from: node[3]),
//            Edge(to: node[1], from: node[4]),
//            Edge(to: node[14], from: node[1]),
//            Edge(to: node[1], from: node[3]),
//            Edge(to: node[2], from: node[4]),
//            Edge(to: node[16], from: node[5]),
//            Edge(to: node[1], from: node[6]),
//            Edge(to: node[6], from: node[7]),
//            Edge(to: node[9], from: node[8]),
//            Edge(to: node[10], from: node[8]),
//            Edge(to: node[11], from: node[8]),
//            Edge(to: node[12], from: node[8]),
//            Edge(to: node[13], from: node[8]),
//            Edge(to: node[14], from: node[8]),
//            Edge(to: node[15], from: node[8]),
//            Edge(to: node[16], from: node[8]),
//            Edge(to: node[21], from: node[22]),
//            Edge(to: node[12], from: node[23]),
//            Edge(to: node[12], from: node[14]),
//            Edge(to: node[14], from: node[1]),
//            Edge(to: node[21], from: node[23]),
//            Edge(to: node[2], from: node[24]),
//            Edge(to: node[16], from: node[25]),
//            Edge(to: node[1], from: node[26]),
//            Edge(to: node[26], from: node[27]),
//            Edge(to: node[29], from: node[28]),
//            Edge(to: node[10], from: node[8]),
//            Edge(to: node[11], from: node[13]),
//            Edge(to: node[12], from: node[23]),
//            Edge(to: node[13], from: node[8]),
//            Edge(to: node[14], from: node[8]),
//            Edge(to: node[15], from: node[8]),
//            Edge(to: node[16], from: node[8]),
//            Edge(to: node[29], from: node[28]),
//            Edge(to: node[10], from: node[30]),
//            Edge(to: node[15], from: node[29]),
//            Edge(to: node[12], from: node[23]),
//            Edge(to: node[13], from: node[22]),
//            Edge(to: node[14], from: node[25]),
//            Edge(to: node[15], from: node[21]),
//            Edge(to: node[16], from: node[20])
        ]
        
        let graph = Graph(nodes: nodes, edges: edges)
//            .timeStep(value: 60)
//            .force(name: "link", force: Link()
//                .springLength(value: 400)
//
//                .springCoefficient(value: 0.00008))
//            .force(name: "nBody", force: NBody()
//                .strength(value: -240)
//                .minDistance(value: 20)
//                .maxDistance(value: .infinity)
////                .theta(value: 0.1)
//        )
////            .force(name: "collision", force: Collision())
//            .force(name: "position", force: Position()
//                .strength(closure: { _ in
//                    return 0.001
//                })
//            )
//            .drag(value: -0.4)
//            .energyThreshold(value: 0.1)
//            .maxVelocity(value: 1)
//
//
//
//        let tickCallback = {
//            DispatchQueue.global(qos: .background).async {
//
//                graph.update { (nodes) in
//
//                }
//
//                DispatchQueue.main.async {
//                    self.graphView.updateCircles()
//                    self.graphView.updateEdges()
//
//                }
//            }
//        }
//
//        let tapCircleCallback: (Node) -> () = { node in
//            let newNode = Node(mass: mass, radius: radius, parentNode: node)
//            let newEdge = Edge(to: newNode, from: node)
//
//            graph.add(node: newNode)
//            graph.add(edge: newEdge)
//
//            self.graphView.addCircle(node: newNode)
//            self.graphView.updateEdges()
//        }
        
        self.graphView = GraphView(graph: graph)
//        ,
//                                   tickCallback: tickCallback,
//                                   tapCircleCallback: tapCircleCallback)
//        graph.step()
        
        scrollView.display(self.graphView)
        self.view.addSubview(scrollView)
        
//        self.graphView.start()
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        scrollView.setup()

        
        
        self.view.isMultipleTouchEnabled = true
        self.graphView.isMultipleTouchEnabled = true
        

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

}

