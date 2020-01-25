//
//  QuizScoreSheet.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-24.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct QuizScoreSheet: View {
    
    @Binding var quizProcessor: QuizProcessor
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack (spacing: 20) {
            Text("Final Score")
                .font(.largeTitle)
            Text("\(quizProcessor.totalScore)/10")
                .font(.title)
            Spacer()
            // TODO add list of questions, green or false based on answers
//            ForEach() {
//                
//            }
            
            Button("Dismiss") {
                self.isPresented = false
            }
            .font(.title)
        }
    .padding()
    }
}

struct QuizScoreSheet_Previews: PreviewProvider {
    static var previews: some View {
        QuizScoreSheet(quizProcessor: .constant(QuizProcessor(questionsArray: Question.questionsArray(), questionNumber: 1)),
                       isPresented: .constant(false))
    }
}
