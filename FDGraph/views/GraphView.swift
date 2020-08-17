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
    
    private var graph: GraphEngine?
    
    var circles: [Circle] = []
    
    let edgeLayer: EdgeLayer = EdgeLayer()
    
    init(nodes: [Node])
//    ,
//         tickCallback: @escaping () -> (),
//         tapCircleCallback: @escaping (Node) -> ())
    {
        
        let frame = CGRect(x: 0, y: 0, width: GraphController.GRAPH_CANVAS_SIZE, height: GraphController.GRAPH_CANVAS_SIZE)
        
        
        
//        self.tickCallback = tickCallback
//        self.tapCircleCallback = tapCircleCallback
        
    
        super.init(frame: frame)
        
        self.graph = GraphEngine(containerView: self)
        
        self.graph?.add(nodes: nodes)
        self.graph?.add(edges: [])
        
        
        self.layer.insertSublayer(edgeLayer, at: 0)
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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

