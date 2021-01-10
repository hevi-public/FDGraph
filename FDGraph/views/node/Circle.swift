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
    
    static let radius: CGFloat = 10
    var radiusMultiplier: CGFloat
    private var color: UIColor!
    
    private var circleLayer: CAShapeLayer!
    
    public convenience init(radiusMultiplier: CGFloat, color: UIColor) {
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: Circle.radius * 2 * radiusMultiplier,
                           height: Circle.radius * 2 * radiusMultiplier)
        
        self.init(frame: frame)
        
        self.radiusMultiplier = radiusMultiplier
        
        self.color = color
        
        self.circleLayer = self.drawCircleOnLayer(size: CGSize(width: frame.width, height: frame.height))
        
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
    
    public func updateColor(color: UIColor) {
        self.color = color
        self.circleLayer.fillColor = color.cgColor
    }
    
    // -MARK: ADD GLOW
    public func addGlow(color: UIColor, opacity: Float) {
        
        let multipliedRadius = Circle.radius * self.radiusMultiplier
        let shadowRadius = multipliedRadius * 3
        let rect = CGRect(x: 0, y: 0, width: shadowRadius, height: shadowRadius)
        
        self.layer.shadowPath = UIBezierPath(ovalIn: rect).cgPath
        self.layer.shadowOffset = CGSize(width: -(multipliedRadius / 2), height: -(multipliedRadius / 2))
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = CGFloat(shadowRadius)
        self.layer.shadowOpacity = opacity
    }
    
    public func removeGlow() {
        self.layer.shadowPath = nil
        self.layer.shadowOpacity = 0
    }

    // MARK: - PRIVATE FUNC
    private func drawCircleOnLayer(size: CGSize) -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        circleLayer.bounds = circleLayer.frame
        
        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: size.width / 2, y: size.height / 2, width: size.width, height: size.height)).cgPath
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
        
        let circleSize = CGSize(width: Circle.radius * 2 * radiusMultiplier, height: Circle.radius * 2 * radiusMultiplier)
        
        circleLayer = drawCircleOnLayer(size: circleSize)
        circleLayer.frame = CGRect(x: -circleSize.width / 2, y: -circleSize.height / 2, width: circleSize.width, height: circleSize.height)
        layer.addSublayer(circleLayer)

    }
}
