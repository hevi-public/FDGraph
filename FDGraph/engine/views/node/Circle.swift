//
//  Circle.swift
//  ForceDirectedNew
//
//  Created by Hevi on 30/07/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

public enum ContentType {
    case text
}

public class Circle: UIView {
    
    private static var glowingCircles = [Circle]()
    static let radius: CGFloat = 10
    private var multipliedRadius: CGFloat
    private var color: UIColor!
    
    public convenience init(radiusMultiplier: CGFloat, color: UIColor, contentType: ContentType) {
        
        let multipliedRadius = Circle.radius * radiusMultiplier
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: multipliedRadius * 2,
                           height: multipliedRadius * 2)
        
        self.init(frame: frame)
        
        self.multipliedRadius = multipliedRadius
        
        self.color = color
        
        let circleLayer = self.drawCircleOnLayer(multipliedRadius: multipliedRadius)

        self.layer.addSublayer(circleLayer)

        self.isUserInteractionEnabled = true
        
        
    }
    
    public override init(frame: CGRect) {
        
        self.multipliedRadius = Circle.radius
        
        super.init(frame: frame)
        
        self.frame = frame
        self.bounds = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // -MARK: ADD GLOW
    public func addGlow() {
        
        let shadowRadius = self.multipliedRadius * 3
        let rect = CGRect(x: 0, y: 0, width: shadowRadius, height: shadowRadius)
        
        self.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        self.layer.shadowOffset = CGSize(width: -(self.multipliedRadius / 2), height: -(self.multipliedRadius / 2))
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOpacity = 1
        
        Circle.glowingCircles.append(self)
    }
    
    public static func removeAllGlow() {
        Circle.glowingCircles.forEach {
            $0.layer.shadowOpacity = 0
        }
        Circle.glowingCircles.removeAll()
    }
    
    public static func getSelectedCircles() -> [Circle] {
        var copy = [Circle]()
        copy.append(contentsOf: Circle.glowingCircles)
        return copy
    }
    
    // MARK: - PRIVATE FUNC
    private func drawCircleOnLayer(multipliedRadius: CGFloat) -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = frame
        
        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: multipliedRadius * 2, height: multipliedRadius * 2)).cgPath
        circleLayer.fillColor = color.cgColor
        
        circleLayer.strokeColor = UIColor.gray.cgColor
        circleLayer.lineWidth = 0
        
        return circleLayer
    }
}
