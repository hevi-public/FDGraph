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
        
        
        
        self.graphView = GraphView(nodes: nodes)
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

