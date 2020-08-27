//
//  GraphTextViewView.swift
//  FDGraph
//
//  Created by Hevi on 27/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class GraphTextNode: BaseView {
    
    private let graphUITextView: GraphUITextView
    
    convenience init(text: String, fontSize: CGFloat, radius: CGFloat, baseHeight: Int, textFieldWidth: Int, textFieldHeight: Int, circleColor: UIColor, frame: CGRect) {

        self.init(circle: Circle(radius: radius, color: UIColor.blue),
                  width: frame.width,
                  height: frame.height)
        
        self.graphUITextView.setup(text: text,
                                   fontSize: fontSize,
                                   radius: radius,
                                   baseHeight: baseHeight,
                                   textFieldWidth: textFieldWidth,
                                   textFieldHeight: textFieldHeight)
        
        self.addSubview(self.graphUITextView)
        
        super.sizeToFit()
        self.sizeToFit()
    }
    
    override init(frame: CGRect) {
        self.graphUITextView = GraphUITextView()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.graphUITextView = GraphUITextView()
        super.init(coder: aDecoder)
    }
}
