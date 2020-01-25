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
    @State private var articlePresented: Bool = false
    @State private var quizProcessor = QuizProcessor(questionsArray: Question.questionsArray(), questionNumber: 1)
    
    var body: some View {
        startScreen
    }
    
    var startScreen: some View {
        VStack (spacing: 20) {
            Spacer()
            Text("Welcome to \nthe GCD Quiz!")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            Text("This is a companion app to my article on concurrency.")
                .multilineTextAlignment(.center)
                Text("I suggest trying the quiz before and then after reading the article to see how your score changes")
                .multilineTextAlignment(.center)
            Button("Start Quiz") {
                self.quizPresented = true
            }
            .font(.title)
            .sheet(isPresented: $quizPresented) {
                QuestionContainer(quizProcessor: self.$quizProcessor,
                                  isPresented: self.$quizPresented,
                                  explanation: .constant(false))
            }
            Spacer()
            Button("Read Article") {
                self.articlePresented = true
            }
            .font(.headline)
            .alert(isPresented: self.$articlePresented) {
                Alert(title: Text("Coming soon!"))
            }
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
