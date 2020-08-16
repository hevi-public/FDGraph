//
//  Particle.swift
//  FDGraph
//
//  Created by Hevi on 15/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import CoreGraphics

public protocol Particle: Hashable {
    var position: CGPoint { get set }
    var velocity: CGPoint { get set }
    var fixed: Bool { get set }
    
    func tick()
}
