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
        
        self.viewParticleCenter = Center(CGPoint(x: frame.width / 2, y: frame.height / 2))
        
        super.init(frame: frame)
        
        for i in 0...nodes.count - 1 {
            self.addSubview(nodes[i].view)
        }
        
        self.layer.insertSublayer(edgeLayer, at: 0)
        
        links.link(between: nodes[0], and: nodes[1], strength: 0.007)
        links.link(between: nodes[2], and: nodes[1], strength: 0.007)
        links.link(between: nodes[2], and: nodes[3], strength: 0.007)
        links.link(between: nodes[2], and: nodes[4], strength: 0.007)
        links.link(between: nodes[2], and: nodes[5], strength: 0.007)
        links.link(between: nodes[2], and: nodes[6], strength: 0.007)
        
        nodes.forEach { (node) in
            simulation.particles.update(with: node)
        }
        
        simulation.start()
        
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

