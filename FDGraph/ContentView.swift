//
//  ContentView.swift
//  FDGraph
//
//  Created by Hevi on 14/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GraphUIView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GraphUIView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = GraphController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<GraphUIView>) -> GraphController {
        GraphController()
    }
    
    func updateUIViewController(_ uiViewController: GraphController, context: UIViewControllerRepresentableContext<GraphUIView>) {
        
    }
}
