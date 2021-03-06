//
//  Force.swift
//  FDGraph
//
//  Created by Hevi on 15/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import CoreGraphics

public protocol Force {

    func tick(alpha: CGFloat, particles: inout Set<NodeParticle>)
}
