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
    @State private var explanationPresented = false
    
    var body: some View {
        VStack (spacing: 10) {
            Text("The Concurrency Quiz")
                .font(.largeTitle)
            Text("Your final score is...")
                .font(.title)
            Text("\(quizProcessor.totalScore)/\(quizProcessor.questionsArray.count)")
                .font(.title)
            
            Spacer(minLength: 0)
            image
            Spacer(minLength: 0)
            scores
            Spacer(minLength: 0)
            Button("Dismiss") {
                self.isPresented = false
            }
            .font(.title)
        }
        .padding()
    }
    
    var image: some View {
        let imageName: String
        switch quizProcessor.totalScore {
        case 10: imageName = "top"
        case 8...9: imageName = "high"
        default: imageName = "low"
        }
        return GeometryReader { proxy in
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: proxy.size.width * 0.75)
                .frame(maxHeight: proxy.size.height)
                .clipped()
        }
    }
    
    var scores: some View {
        VStack (spacing: 20) {
            Text("Tap on questions for explanation")
            ForEach(0..<quizProcessor.questionsArray.count / 2) { row in

                HStack (spacing: 90) {
                    ScoreButton(index: row * 2, quizProcessor: self.quizProcessor) {
                        self.quizProcessor.explain(question: row * 2 + 1)
                        self.explanationPresented = true
                    }
                    ScoreButton(index: row * 2 + 1, quizProcessor: self.quizProcessor) {
                        self.quizProcessor.explain(question: row * 2 + 2)
                        self.explanationPresented = true
                    }
                }
            }
        }
        .padding(.bottom, 10)
        .sheet(isPresented: $explanationPresented) {
            QuestionContainer(quizProcessor: self.$quizProcessor,
                              isPresented: .constant(false),
                              explanation: self.$explanationPresented)
        }
    }
    
}

struct QuizScoreSheet_Previews: PreviewProvider {
    
    static let sampleQuiz: QuizProcessor = {
        
        var quiz = QuizProcessor(questionsArray: Question.questionsArray(), questionNumber: 1)
        
        quiz.score = [
            1: true, 2: true, 3: true, 4: true, 5: true,
            6: true, 7: true, 8: false, 9: false , 10: false
        ]
        
        return quiz
    }()
    
    static var previews: some View {
        QuizScoreSheet(quizProcessor: .constant(sampleQuiz),
                       isPresented: .constant(false))
    }
}
