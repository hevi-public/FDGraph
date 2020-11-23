//
//  ContentView.swift
//  FDGraph
//
//  Created by Hevi on 14/08/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let graphUIView = GraphUIView()
    
    var body: some View {
        
        ZStack {
            graphUIView
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button(action: {
                        self.graphUIView.addChildToSelectedNode()
                    }) {
                        Text("Add child to selected node")
                            .padding()
                    }
                }.padding()
            }
        }
    }
}
