//
//  GraphView.swift
//  ForceDirectedNew
//
//  Created by Hevi on 13/03/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation
import UIKit

class GraphView: UIView {
    
    lazy var graph: GraphEngine = {
        let graphEngine = GraphEngine(containerView: self)
        return graphEngine
    }()
    
    init(width: CGFloat, height: CGFloat) {
        
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
    
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.1415973902, green: 0.1211834475, blue: 0.1376207769, alpha: 1)
//        self.backgroundColor = #colorLiteral(red: 0.1752695441, green: 0.1928083599, blue: 0.3296577334, alpha: 1)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
