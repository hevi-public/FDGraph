//
//  GraphController.swift
//  ForceDirectedNew
//
//  Created by Hevi on 13/03/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

// -MARK: DECLARATIONS
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
    
    private lazy var graphView: GraphView = {
        return GraphView(width: GraphController.GRAPH_CANVAS_SIZE, height: GraphController.GRAPH_CANVAS_SIZE)
    }()
    
    // -MARK: VIEWDIDLOAD
    override func viewDidLoad() {
        print("GraphController viewDidLoad")

        
        scrollView.display(self.graphView)
        self.view.addSubview(scrollView)
        
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

// -MARK: PUBLIC METHODS
extension GraphController {
    public func add(nodes: [Node]) {
        self.graphView.add(nodes: nodes)
    }
    
    public func add(edges: [Links]) {
        self.graphView.add(edges: edges)
    }
    
    public func focus(node: Node) {
        UIView.animate(withDuration: 0.3, animations: {
            let newX = node.position.x - self.scrollView.bounds.width / 2
            let newY = node.position.y - self.scrollView.bounds.height / 2
            
            self.scrollView.contentOffset = CGPoint(x: newX, y: newY)
        })
    }
}
