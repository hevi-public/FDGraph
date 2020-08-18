//
//  Node.swift
//  FDGraph
//
//  Created by Hevi on 15/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import UIKit

public protocol NodeParticleDelegate {
    
    func handleTap(node: Node)
}

public class Node: Particle {
  
    public var position: CGPoint
    public var velocity: CGPoint
    public var fixed: Bool = false
    
    var view: UIView
    
    public var delegate: NodeParticleDelegate?
    
    init(radius: CGFloat) {
        
        
        let randomX = CGFloat.random(in: 0 ..< 1) / 10
        let randomY = CGFloat.random(in: 0 ..< 1) / 10
        
        self.position = CGPoint(x: randomX, y: randomY)
        self.velocity = CGPoint.zero
        self.view = Circle.createCircle(radius: radius)
       
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    public func tick() {
        view.center = position
    }
    
}

extension Node {
    @objc func handleTap(sender: UITapGestureRecognizer) {
        
        self.delegate?.handleTap(node: self)
    }
}

extension Node: Equatable {
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.view == rhs.view
    }
}

extension Node: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(view.hashValue)
    }
}


