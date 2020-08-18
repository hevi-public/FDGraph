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
    
    private static var glowingCircles = [Circle]()
    
    let cirucumference: CGFloat
    var radius: CGFloat {
        get {
            cirucumference / 2
        }
    }
    
    private var color: UIColor!
    
    public override init(frame: CGRect) {
        self.cirucumference = frame.width
        
        super.init(frame: frame)
        
        self.frame = frame
        self.bounds = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func createCircle(radius: CGFloat, color: UIColor) -> Circle {
        
        let frame = CGRect(origin: CGPoint(x: Int.random(in: 2...10), y: Int.random(in: 2...10)),
                           size: CGSize(width: radius * 2, height: radius * 2))
        
        let cirucumference = frame.width
        let radius = cirucumference / 2
        
        let baseWidth = cirucumference
        let baseHeight = cirucumference
        
        let v = Circle(frame: frame)
        v.color = color
        
        let layer = CAShapeLayer()
        layer.frame = frame
        
        layer.path = UIBezierPath(ovalIn: CGRect(x: -radius + baseWidth / 2, y: -radius + baseHeight / 2, width: cirucumference, height: cirucumference)).cgPath
        layer.fillColor = color.cgColor
        
        layer.strokeColor = UIColor.gray.cgColor
        layer.lineWidth = 0

        v.layer.addSublayer(layer)

        v.isUserInteractionEnabled = true
        
        return v
    }
    
    // -MARK: ADD GLOW
    public func addGlow() {
        
        self.layer.shadowOffset = .zero
        self.layer.shadowColor = UIColor.blue.cgColor
        self.layer.shadowRadius = 120
        self.layer.shadowOpacity = 0.1
        
        
        let multiplier = 2.0
        
        let width = Double(self.bounds.size.width)
        let widthMultiplied = width * multiplier
        let widthHalf = width / 2
        let widthHalfMultiplied = widthHalf * multiplier
        
        
        let rect = CGRect(x: -(widthHalfMultiplied) + (widthHalf), y: -(widthHalfMultiplied) + Double(self.frame.size.height / 2), width: widthMultiplied, height: widthMultiplied)
        
        self.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        
        Circle.glowingCircles.append(self)
    }
    
    public static func removeAllGlow() {
        
        Circle.glowingCircles.forEach {
            $0.layer.shadowOpacity = 0
        }
        Circle.glowingCircles.removeAll()
        
        
    }
}
