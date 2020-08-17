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
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius * 1.1)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius * 1.4)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius * 1.2)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius * 1.3)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius * 1.1)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius * 1.5)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius * 1.6)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius * 1.5)),
        Node(view: Circle.createCircle(radius: radius)),
        Node(view: Circle.createCircle(radius: radius))
    ]
    
    var body: some View {
        
        
        return GraphUIView(nodes: $nodes)
    }
}
