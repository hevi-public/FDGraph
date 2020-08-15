//
//  Node.swift
//  FDGraph
//
//  Created by Hevi on 15/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import UIKit

public class Node: Particle {
  
    var mass: CGFloat
    public var position: CGPoint
    public var velocity: CGPoint
    public var fixed: Bool = false
    
    var view: UIView
    
    init(mass: CGFloat, view: UIView) {
        self.mass = mass
        self.position = CGPoint.zero
        self.velocity = CGPoint.zero
        self.view = view
    }
    
    public func tick() {
        view.center = position
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
