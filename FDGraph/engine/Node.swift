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
    
    var view: BaseView
    
    public var delegate: NodeParticleDelegate?
    
    init(radiusMultiplier: CGFloat) {
        
        
        let randomX = CGFloat.random(in: 0 ..< 1) / 10
        let randomY = CGFloat.random(in: 0 ..< 1) / 10
        
        self.position = CGPoint(x: randomX, y: randomY)
        self.velocity = CGPoint.zero

        self.view = GraphTextNode(text: "asdf", fontSize: 12.0, radiusMultiplier: radiusMultiplier, baseHeight: 50, textFieldWidth: 100, textFieldHeight: 200, circleColor: UIColor.blue, frame: CGRect(x: 0, y: 0, width: 200, height: 400))
       
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(sender:)))
        self.view.addGestureRecognizer(singleTapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTapGesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTapGesture)
        
    }
    
    public func tick() {
        view.center = position
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
        return lhs.view == rhs.view
    }
}

// -MARK: HASHABLE
extension Node: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(view.hashValue)
    }
}


