//
//  ContentView.swift
//  FDGraph
//
//  Created by Hevi on 14/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    static let radius = CGFloat(10)
    
    @State var nodes: [Node] = [
        Node(radius: radius),
        Node(radius: radius * 1.1),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.4),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.2),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.3),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.1),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius),
        Node(radius: radius * 1.5),
        Node(radius: radius),
        Node(radius: radius * 1.6),
        Node(radius: radius),
        Node(radius: radius * 1.5),
        Node(radius: radius),
        Node(radius: radius)
    ]
    
    var body: some View {
        
        
        return GraphUIView(nodes: $nodes)
    }
}
