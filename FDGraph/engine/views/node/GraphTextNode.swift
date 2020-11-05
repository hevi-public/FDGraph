//
//  GraphTextViewView.swift
//  FDGraph
//
//  Created by Hevi on 27/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class GraphTextNode: UIView {
    
    private let graphUITextView: GraphUITextView
    
    convenience init(text: String, fontSize: CGFloat, baseHeight: Int, textFieldWidth: Int, textFieldHeight: Int, circleColor: UIColor) {

        let frame = CGRect(x: 0, y: 0, width: textFieldWidth, height: textFieldHeight)
        
        self.init(frame: frame)
        
        self.graphUITextView.setup(text: text,
                                   fontSize: fontSize,
                                   baseHeight: baseHeight,
                                   textFieldWidth: textFieldWidth,
                                   textFieldHeight: textFieldHeight)
        
        self.addSubview(self.graphUITextView)
        
//        super.sizeToFit()
//        self.sizeToFit()
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
