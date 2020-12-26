//
//  CircleContainer.swift
//  FDGraph
//
//  Created by Hevi on 05/11/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

public enum ContentType {
    case text
}

class CircleContainer: UIView {
    
    var circle: Circle!
    var content: UIView!
    var contentType: ContentType!
    
    private static let distanceBetweenCircleAndContent: CGFloat = 10
    
    public convenience init(graphUITextdelegate: GraphUITextDelegate, text: String, radiusMultiplier: CGFloat, color: UIColor, contentType: ContentType) {
        
        let circleView = Circle(radiusMultiplier: radiusMultiplier, color: color)
        circleView.sizeToFit()
        
        var contentView = UIView()
        
        switch contentType {
        case .text:
            contentView = GraphTextNode(graphUITextdelegate: graphUITextdelegate,
                                        text: text,
                                        fontSize: 12.0,
                                        baseHeight: 50,
                                        textFieldWidth: 100,
                                        textFieldHeight: 200,
                                        circleColor: UIColor.blue)
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

        
        NSLayoutConstraint.activate([
            
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
    
    func updateCircleSize(nodeValue: CGFloat) {

        circle.radiusMultiplier = 1 + nodeValue / 30
        circle.sizeToFit()
    }
    
    func updateCircleColor(color: UIColor) {
        circle.updateColor(color: color)
    }
    
//    public override func sizeThatFits(_ size: CGSize) -> CGSize {
//        circle.sizeToFit()
//        return size
//    }
    
    public override func layoutSubviews() {
        circle.center = CGPoint(x: (self.frame.width) / 2,
                                y: circle.frame.height / 2)
    }
}
