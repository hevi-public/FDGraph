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
    
    let textView: GraphUITextView
    
    convenience init(graphUITextdelegate: GraphUITextDelegate, text: String, fontSize: CGFloat, textFieldWidth: Int, textFieldHeight: Int, circleColor: UIColor) {
        
        let frame = CGRect(x: 0, y: 0, width: textFieldWidth, height: textFieldHeight)
        
        self.init(frame: frame)
        
        self.textView.setup(graphUITextdelegate: graphUITextdelegate,
                            text: text,
                            fontSize: fontSize,
                            textFieldWidth: textFieldWidth,
                            textFieldHeight: textFieldHeight)
        
        self.addSubview(self.textView)
        
        //        super.sizeToFit()
        //        self.sizeToFit()
    }
    
    override init(frame: CGRect) {
        self.textView = GraphUITextView()
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.textView = GraphUITextView()
        super.init(coder: aDecoder)
    }
}
