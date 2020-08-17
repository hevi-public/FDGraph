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
    
    public lazy var simulation: Simulation = {
        let simulation: Simulation = Simulation()
        simulation.insert(force: self.manyParticle)
        simulation.insert(force: self.links)
        simulation.insert(force: self.viewParticleCenter)
        simulation.insert(tick: { self.linkLayer.path = self.links.path(from: &$0) })
        return simulation
    }()
    
    private lazy var linkLayer: CAShapeLayer = {
        let linkLayer = CAShapeLayer()
        linkLayer.strokeColor = UIColor.gray.cgColor
        linkLayer.fillColor = UIColor.clear.cgColor
        linkLayer.lineWidth = 1
        self.layer.insertSublayer(linkLayer, at: 0)
        return linkLayer
    }()
    
    internal let viewParticleCenter: Center!
    private let manyParticle: ManyParticle = ManyParticle()
    private let links: Links = Links()

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
        
        self.viewParticleCenter = Center(CGPoint(x: frame.width / 2, y: frame.height / 2))
        
        super.init(frame: frame)
        
        let nodes = graph.nodes
        
        for i in 0...nodes.count - 1 {
            self.addSubview(nodes[i].view)
        }
        
        self.layer.insertSublayer(edgeLayer, at: 0)
        
        links.link(between: nodes[0], and: nodes[1])
        links.link(between: nodes[2], and: nodes[1])
        links.link(between: nodes[2], and: nodes[3])
        links.link(between: nodes[2], and: nodes[4])
        links.link(between: nodes[2], and: nodes[5])
        links.link(between: nodes[2], and: nodes[6])
        
        graph.nodes.forEach { (node) in
            simulation.particles.update(with: node)
        }
        
        simulation.start()
        
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
    
//    public func addCircle(node: Node) {
////        let circle = Circle.createCircle(radius: 10)
//
////        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
////        circle.addGestureRecognizer(tapGesture)
//        circles.append(circle)
//
//        self.addSubview(circle)
//
////        self.tick()
//    }
    
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
    
//    public func start() {
//        guard displayLink == nil else { return }
//        print("simulation start...")
//        let link = CADisplayLink(target: self, selector: #selector(tick))
//        link.add(to: RunLoop.main, forMode: RunLoop.Mode.common)
//        displayLink = link
//    }
//    
//    public func stop() {
//        print("simulation stop...")
//        displayLink?.remove(from: RunLoop.main, forMode: RunLoop.Mode.common)
//    }
    
//    @objc private func tick() {
////        self.tickCallback()
//    }
//
//    @objc func handleTap(sender: UITapGestureRecognizer) {
//        guard let node = (sender.view as? Circle)?.node else { return }
//
//        self.tapCircleCallback(node)
//    }
    
}

