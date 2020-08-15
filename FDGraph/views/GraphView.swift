//
//  GraphView.swift
//  ForceDirectedNew
//
//  Created by Hevi on 13/03/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class GraphView: UIView {
    
//    private var tickCallback: () -> ()
//    private var tapCircleCallback: (Node) -> ()
    
    private weak var displayLink: CADisplayLink?

    private var graph: Graph
    
    var circles: [Circle] = []
    
    let edgeLayer: EdgeLayer = EdgeLayer()
    
    init(graph: Graph)
//    ,
//         tickCallback: @escaping () -> (),
//         tapCircleCallback: @escaping (Node) -> ())
    {
        
        let frame = CGRect(x: 0, y: 0, width: GraphController.GRAPH_CANVAS_SIZE, height: GraphController.GRAPH_CANVAS_SIZE)
        
        self.graph = graph
        
//        self.tickCallback = tickCallback
//        self.tapCircleCallback = tapCircleCallback
        
        
        
        super.init(frame: frame)
        
        let nodes = graph.nodes
        
        for i in 0...nodes.count - 1 {
            self.addCircle(node: nodes[i])
        }
        
        self.layer.insertSublayer(edgeLayer, at: 0)
        
        /////////
//        for i in 0...edges.count - 1 {
//            let edge = createEdge(bounds: self.bounds, edge: edges[i])
//            edgeViews.append(edge)
//        }
//
//        for i in 0...edgeViews.count - 1 {
//            self.addSubview(edgeViews[i])
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addCircle(node: Node) {
        let circle = Circle.createCircle(radius: 10)
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
//        circle.addGestureRecognizer(tapGesture)
        circles.append(circle)
        
        self.addSubview(circle)
        
//        self.tick()
    }
    
    func updateCircles() {

        
        
        for circle in circles {
            
            let width = circle.bounds.width
            let height = circle.bounds.height
            
            
//            guard let node = circle.node else { continue }
//            
//            let x = self.bounds.width / 2 + (node.position.x - node.radius)
//            let y = self.bounds.height / 2 + (node.position.y - node.radius)
//            
//            
//            
//            circle.frame = CGRect(x: x, y: y, width: width, height: height)
        }
    }
    
    func updateEdges() {
        
        let edges = self.graph.edges
        
        edgeLayer.update(edges: edges, offset: self.bounds.width / 2)
        
//        for i in 0...edgeViews.count - 1 {
//            let x = 2500 + self.nodes[i].position.x
//            let y = 2500 + self.nodes[i].position.y
//
//            let edge = edgeViews[i]
//            edge.setNeedsDisplay()
//
//        }
    }
    
    
    
//    func createEdge(bounds: CGRect, edge: Edge) -> EdgeView {
//        let edgeView = EdgeView()
//        edgeView.update(nodeTo: edge.to, nodeFrom: edge.from)
//
//        return edgeView
//    }
    
    // - MARK: Simulation
    
    public func start() {
        guard displayLink == nil else { return }
        print("simulation start...")
        let link = CADisplayLink(target: self, selector: #selector(tick))
        link.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
        displayLink = link
    }
    
    public func stop() {
        print("simulation stop...")
        displayLink?.remove(from: RunLoop.main, forMode: RunLoop.Mode.common)
    }
    
    @objc private func tick() {
//        self.tickCallback()
    }
//
//    @objc func handleTap(sender: UITapGestureRecognizer) {
//        guard let node = (sender.view as? Circle)?.node else { return }
//
//        self.tapCircleCallback(node)
//    }
    
}

