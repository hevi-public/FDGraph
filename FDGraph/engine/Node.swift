//
//  Node.swift
//  FDGraph
//
//  Created by Hevi on 15/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import UIKit

class Node {
  
    var mass: CGFloat
    var radius: CGFloat
    var position: CGPoint
    
    init(mass: CGFloat, radius: CGFloat) {
        self.mass = mass
        self.radius = radius
        self.position = CGPoint.zero
    }
    
} 
