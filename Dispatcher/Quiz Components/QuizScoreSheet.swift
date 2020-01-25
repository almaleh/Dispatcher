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
            Text("\(quizProcessor.totalScore)/\(quizProcessor.questionsArray.count)")
                .font(.title)
            Spacer(minLength: 0)
            scores
            Button("Dismiss") {
                self.isPresented = false
            }
            .font(.title)
        }
        .padding()
    }
    
    var scores: some View {
        VStack (spacing: 30) {
            Text("Tap on questions for explanation")
            ForEach(0..<quizProcessor.questionsArray.count / 2) { row in
                
                HStack (spacing: 90) {
                    ScoreButton(index: row * 2, quizProcessor: self.quizProcessor)
                    ScoreButton(index: row * 2 + 1, quizProcessor: self.quizProcessor)
                }
            }
        }
        .padding(.bottom, 20)
    }
}

struct QuizScoreSheet_Previews: PreviewProvider {
    
    static var sampleQuiz: QuizProcessor = {
        
        var quiz = QuizProcessor(questionsArray: Question.questionsArray(), questionNumber: 1)
        
        quiz.score = [
            1: true, 2: true, 3: true, 4: false, 5: false,
            6: true, 7: false, 8: false, 9: true , 10: false
        ]
        
        return quiz
    }()
    
    static var previews: some View {
        QuizScoreSheet(quizProcessor: .constant(sampleQuiz),
                       isPresented: .constant(false))
    }
}
