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
            Text("Welcome to \nthe Concurrency Quiz!")
                .multilineTextAlignment(.center)
                .font(.largeTitle)
            Text("Try the quiz before and after reading the article to see how your score changes")
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
            Button("Read the Article") {
                UIApplication.shared.open(URLConstants.articlePart1)
            }
            .font(.headline)
            Text("by Besher Al Maleh")
            Text("Don't forget to check the other tab!")
                .multilineTextAlignment(.center)
                .font(.caption)
                .padding()
        }
        .padding()
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}
