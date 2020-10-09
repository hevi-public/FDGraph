//
//  Node.swift
//  FDGraph
//
//  Created by Hevi on 15/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import UIKit

// -MARK: DELEGATE
public protocol NodeParticleDelegate {
    
    func handleSingleTap(node: Node)
    func handleDoubleTap(node: Node)
}

// -MARK: NODE
public class Node: Particle {
  
    public var position: CGPoint
    public var velocity: CGPoint
    public var fixed: Bool = false
    
    var circle: Circle
    
    public var delegate: NodeParticleDelegate?
    
    init(radiusMultiplier: CGFloat, contentType: ContentType) {
        
        
        let randomX = CGFloat.random(in: 0 ..< 1) / 10
        let randomY = CGFloat.random(in: 0 ..< 1) / 10
        
        self.position = CGPoint(x: randomX, y: randomY)
        self.velocity = CGPoint.zero
        
        self.circle = Circle(radiusMultiplier: radiusMultiplier, color: UIColor.blue, contentType: contentType)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
        self.circle.addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.circle.addGestureRecognizer(doubleTapGesture)
        
    }
    
    public func tick() {
        circle.center = position
    }
    
}

// -MARK: DELEGATE HANDLER
extension Node {
    @objc func handleSingleTap(sender: UITapGestureRecognizer) {
        
        self.delegate?.handleSingleTap(node: self)
    }
    
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        
        self.delegate?.handleDoubleTap(node: self)
    }
}

// -MARK: EQUATABLE
extension Node: Equatable {
    
    public static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.circle == rhs.circle
    }
}

// -MARK: HASHABLE
extension Node: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(circle.hashValue)
    }
}


