//
//  ContentView.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-16.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DiagramView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Explanation")
            }
            QuizView()
                .tabItem {
                    Image(systemName: "text.badge.checkmark")
                    Text("Quiz")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
