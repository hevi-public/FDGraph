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
    
    private lazy var graph: GraphEngine = {
        let graphEngine = GraphEngine(containerView: self)
        return graphEngine
    }()
    
    var circles: [Circle] = []
    
    let edgeLayer: EdgeLayer = EdgeLayer()
    
    init(nodes: [Node], width: CGFloat, height: CGFloat)
//    ,
//         tickCallback: @escaping () -> (),
//         tapCircleCallback: @escaping (Node) -> ())
    {
        
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        
        
//        self.tickCallback = tickCallback
//        self.tapCircleCallback = tapCircleCallback
        
    
        super.init(frame: frame)
        
        
        
        self.graph.add(nodes: nodes)
        self.graph.add(edges: [])
        
        
        self.layer.insertSublayer(edgeLayer, at: 0)
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 

//    @objc func handleTap(sender: UITapGestureRecognizer) {
//        guard let node = (sender.view as? Circle)?.node else { return }
//
//        self.tapCircleCallback(node)
//    }
    
}

