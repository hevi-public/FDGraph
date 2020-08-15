//
//  Circle.swift
//  ForceDirectedNew
//
//  Created by Hevi on 30/07/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

public class Circle: UIView {
    
    let cirucumference: CGFloat
    var radius: CGFloat {
        get {
            cirucumference / 2
        }
    }
    
    public override init(frame: CGRect) {
        self.cirucumference = frame.width
        
        super.init(frame: frame)
        
        self.frame = frame
        self.bounds = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createCircle(radius: CGFloat) -> Circle {
        
        let frame = CGRect(origin: CGPoint(x: Int.random(in: 2...10), y: Int.random(in: 2...10)),
                           size: CGSize(width: radius * 2, height: radius * 2))
        
        let cirucumference = frame.width
        let radius = cirucumference / 2
        
        let baseWidth = cirucumference
        let baseHeight = cirucumference
        
        let v = Circle(frame: frame)
        
        let layer = CAShapeLayer()
        layer.frame = frame
        
        layer.path = UIBezierPath(ovalIn: CGRect(x: -radius + baseWidth / 2, y: -radius + baseHeight / 2, width: cirucumference, height: cirucumference)).cgPath
        layer.fillColor = UIColor.blue.cgColor
        
        layer.strokeColor = UIColor.gray.cgColor
        layer.lineWidth = 0

        v.layer.addSublayer(layer)

        v.isUserInteractionEnabled = true
        
        return v
    }
}
