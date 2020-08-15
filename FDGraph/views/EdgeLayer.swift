//
//  EdgeLayer.swift
//  ForceDirectedNew
//
//  Created by Hevi on 14/03/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class EdgeLayer: CAShapeLayer {
    
//    var nodeFrom: Node!
//    var nodeTo: Node!
    
    override init() {
        super.init()
        self.strokeColor = UIColor.blue.cgColor
        self.fillColor = UIColor.clear.cgColor
        self.lineWidth = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(edges: [Edge], offset: CGFloat) {
        let path = CGMutablePath()
        
        for edge in edges {
            let from = CGPoint(x: edge.from.position.x + offset, y: edge.from.position.y + offset)
            let to = CGPoint(x: edge.to.position.x + offset, y: edge.to.position.y + offset)
            
            path.move(to: from)
            path.addLine(to: to)
        }
        
        self.path = path
    }
    
    func draw(_ rect: CGRect) {
        createRectangle()
        
        UIColor.orange.setFill()
//        path.fill()
        
        UIColor.purple.setStroke()
//        path.stroke()
    }
    
    func createRectangle() {
//        path = UIBezierPath()
//
//        path.move(to: CGPoint(x: nodeFrom.position.x, y: nodeFrom.position.y))
//        path.addLine(to: CGPoint(x: nodeTo.position.x, y: nodeTo.position.y))
//        path.addLine(to: CGPoint(x: nodeTo.position.x + 2, y: nodeTo.position.y + 2))
//        path.addLine(to: CGPoint(x: nodeFrom.position.x + 2, y: nodeFrom.position.y + 2))
//        path.close()
    }
}




