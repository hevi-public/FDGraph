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
    static let radius: CGFloat = 10
    var radiusMultiplier: CGFloat
    private var color: UIColor!
    
    private var circleLayer: CAShapeLayer!
    
    public convenience init(radiusMultiplier: CGFloat, color: UIColor) {
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: Circle.radius * 2,
                           height: Circle.radius * 2)
        
        self.init(frame: frame)
        
        self.color = color
        
        self.circleLayer = self.drawCircleOnLayer(size: CGSize(width: 2, height: 2))
        
        self.layer.addSublayer(self.circleLayer)
        
        self.isUserInteractionEnabled = true
        
        
    }
    
    public override init(frame: CGRect) {
        
        self.radiusMultiplier = 1
        
        super.init(frame: frame)
        
        self.frame = frame
        self.bounds = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // -MARK: ADD GLOW
    public func addGlow() {
        
        let multipliedRadius = Circle.radius * self.radiusMultiplier
        let shadowRadius = multipliedRadius * 3
        let rect = CGRect(x: 0, y: 0, width: shadowRadius, height: shadowRadius)
        
        self.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        self.layer.shadowOffset = CGSize(width: -(multipliedRadius / 2), height: -(multipliedRadius / 2))
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
    private func drawCircleOnLayer(size: CGSize) -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = frame
        
        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: size.width, height: size.height)).cgPath
        circleLayer.fillColor = color.cgColor
        
        circleLayer.strokeColor = UIColor.gray.cgColor
        circleLayer.lineWidth = 0
        
        return circleLayer
    }
    
    public override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: Circle.radius * 2 * radiusMultiplier,
                      height: Circle.radius * 2 * radiusMultiplier)
    }

    
    public override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        self.layer.sublayers?.removeAll()
        
        circleLayer = drawCircleOnLayer(size: CGSize(width: Circle.radius * 2 * radiusMultiplier, height: Circle.radius * 2 * radiusMultiplier))
        circleLayer.frame = self.bounds
        layer.addSublayer(circleLayer)

    }
}
