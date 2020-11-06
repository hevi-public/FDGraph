//
//  CircleContainer.swift
//  FDGraph
//
//  Created by Hevi on 05/11/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class CircleContainer: UIView {
    
    var circle: Circle!
    var content: UIView!
    var contentType: ContentType!
    
    private static let distanceBetweenCircleAndContent: CGFloat = 10
    
    public convenience init(radiusMultiplier: CGFloat, color: UIColor, contentType: ContentType) {
        
        let circleView = Circle(radiusMultiplier: radiusMultiplier, color: color, contentType: contentType)
        
        var contentView = UIView()
        
        switch contentType {
        case .text:
            contentView = GraphTextNode(text: "asdf", fontSize: 12.0, baseHeight: 50, textFieldWidth: 100, textFieldHeight: 200, circleColor: UIColor.blue)
        }
        
        
        let width = contentView.frame.width
        let height = circleView.frame.height + CircleContainer.distanceBetweenCircleAndContent + contentView.frame.height
        
        let frame = CGRect(x: 0,
                           y: 0,
                           width: width,
                           height: height)
        
        self.init(frame: frame)
        
//        self.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 0.2028039384)
        
        self.contentType = contentType
        
        self.circle = circleView
        self.addSubview(circle)
        
        self.content = contentView
        self.addSubview(self.content)
        self.content.translatesAutoresizingMaskIntoConstraints = false
        
        self.circle.center = CGPoint(x: (contentView.frame.width) / 2,
                                     y: circleView.frame.height / 2)

//        self.content.center = CGPoint(x: contentView.frame.width / 2,
//                              y: 0)
        
        NSLayoutConstraint.activate([
//            self.circle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            self.content.topAnchor.constraint(equalTo: self.circle.bottomAnchor, constant: CircleContainer.distanceBetweenCircleAndContent),
            self.content.centerXAnchor.constraint(equalTo: self.circle.centerXAnchor)
        ])
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.frame = frame
        self.bounds = frame
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
