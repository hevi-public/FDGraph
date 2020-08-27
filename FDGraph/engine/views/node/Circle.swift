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
    
    let radius: CGFloat
    
    private var color: UIColor!
    
    public convenience init(radius: CGFloat, color: UIColor) {
        
        let frame = CGRect(origin: CGPoint(x: -radius / 2, y: -radius / 2),
                           size: CGSize(width: radius * 2, height: radius * 2))
        
        self.init(frame: frame)
        
        self.color = color
        
        let circleLayer = self.drawCircleOnLayer()

        self.layer.addSublayer(circleLayer)

        self.isUserInteractionEnabled = true
    }
    
    public override init(frame: CGRect) {
        self.radius = frame.width / 2
        
        super.init(frame: frame)
        
        self.frame = frame
        self.bounds = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // -MARK: ADD GLOW
    public func addGlow() {
        
        let shadowRadius = radius * 3
        let rect = CGRect(x: -radius / 2, y: -radius / 2, width: shadowRadius, height: shadowRadius)
        
        self.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        self.layer.shadowOffset = CGSize(width: -(radius / 2), height: -(radius / 2))
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
    private func drawCircleOnLayer() -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = frame
        
        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)).cgPath
        circleLayer.fillColor = color.cgColor
        
        circleLayer.strokeColor = UIColor.gray.cgColor
        circleLayer.lineWidth = 0
        
        return circleLayer
    }
}
