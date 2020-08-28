//
//  BaseView.swift
//  FDGraph
//
//  Created by Hevi on 27/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    var circle: Circle!
    
    convenience init(circle: Circle, width: CGFloat, height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: height))
        self.circle = circle
        self.addSubview(self.circle)
        
        self.backgroundColor = UIColor.cyan
        self.alpha = 0.2
    }
    
    override init(frame: CGRect) {
        self.circle = Circle()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.circle = Circle()
        super.init(coder: aDecoder)
    }
}
