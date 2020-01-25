//
//  QuestionView.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-23.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct QuestionContainer: View {
    
    @State private var quizProcessor = QuizProcessor(questionsArray: Question.questionsArray(), questionNumber: 1)
    @Binding var isPresented: Bool
    
    var body: some View {
        Group {
            if quizProcessor.questionNumber > quizProcessor.questionsArray.count {
                QuizScoreSheet(quizProcessor: $quizProcessor,
                               isPresented: $isPresented)
            } else {
                QuestionView(quizProcessor: $quizProcessor)
            }
        }
    }
    
}

struct QuestionView: View {
    
    @State private var selectedAnswer: Int?
    private var answerWasSelected: Bool { selectedAnswer != nil }
    private var question: Question { quizProcessor.question }
    private var answers: [String] { question.answers }
    
    @Binding var quizProcessor: QuizProcessor
    
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            Text("Question \(quizProcessor.questionNumber)/10")
            Text(question.question)
                .font(.headline)
                .multilineTextAlignment(.center)
            Text(question.code)
                .foregroundColor(.white)
                .lineSpacing(3)
                .font(.system(size: 14, design: .monospaced))
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 500, minHeight: 200)
                .padding([.leading, .trailing, .bottom])
                .background(
                    Color.black.brightness(0.2)
                        .border(Color.black, width: 2)
            )
                .cornerRadius(4)
            VStack (spacing: 10) {
                ForEach(0..<answers.count, id: \.self) { idx in
                    QuestionButton(label: self.answers[idx],
                                   selectedAnswer: self.$selectedAnswer, id: idx)
                }
            }
            Spacer()
            Button("Confirm") {
                self.quizProcessor.answered(with: self.selectedAnswer ?? 0)
                self.selectedAnswer = nil
            }
            .opacity(answerWasSelected ? 1.0 : 0.0)
            .font(.title)
        }
        .padding()
    }
}

struct QuizStartScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(quizProcessor: .constant(QuizProcessor(questionsArray: Question.questionsArray(), questionNumber: 1)))
    }
}
