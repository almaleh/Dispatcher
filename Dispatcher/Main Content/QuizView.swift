//
//  QuizView.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-16.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct QuizView: View {
    
    @State private var quizPresented: Bool = false
    
    var body: some View {
        startScreen
    }
    
    var startScreen: some View {
        VStack (spacing: 20) {
            Spacer()
            Text("Welcome to \nthe GCD Quiz!")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            Text("I suggest trying the quiz before and then after reading the article to see if your score changes")
                .multilineTextAlignment(.center)
            Button("Start Quiz") {
                self.quizPresented = true
            }
            .font(.title)
            .sheet(isPresented: $quizPresented) {
                QuestionContainer(isPresented: self.$quizPresented)
            }
            Spacer()
            Button("Read Article") {
                // TODO add article URL
            }
            .font(.headline)
            Text("by Besher Al Maleh")
        }
    .padding()
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
