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
    
    var circleContainer: CircleContainer
    
    public var delegate: NodeParticleDelegate?
    
    init(radiusMultiplier: CGFloat, contentType: ContentType) {
        
        
        let randomX = CGFloat.random(in: 0 ..< 1) / 10
        let randomY = CGFloat.random(in: 0 ..< 1) / 10
        
        self.position = CGPoint(x: randomX, y: randomY)
        self.velocity = CGPoint.zero
        
        self.circleContainer = CircleContainer(radiusMultiplier: radiusMultiplier, color: UIColor.blue, contentType: contentType)
        
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
        self.circleContainer.addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.circleContainer.addGestureRecognizer(doubleTapGesture)
        
    }
    
    public func tick() {
        let x = position.x
        let y = position.y + (circleContainer.frame.height - circleContainer.circle.frame.height) / 2
        
        circleContainer.center = CGPoint(x: x, y: y)
            
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
        return lhs.circleContainer == rhs.circleContainer
    }
}

// -MARK: HASHABLE
extension Node: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(circleContainer.hashValue)
    }
}


