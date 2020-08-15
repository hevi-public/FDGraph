//
//  Edge.swift
//  FDGraph
//
//  Created by Hevi on 15/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class Edge {
    
    public let weight: CGFloat
    public unowned let to: Node
    public unowned let from: Node
    
    public init(to: Node, from: Node, weight: CGFloat = 1) {
        self.to = to
        self.from = from
        self.weight = weight
//        to.links.append(self)
//        from.links.append(self)
    }
}
