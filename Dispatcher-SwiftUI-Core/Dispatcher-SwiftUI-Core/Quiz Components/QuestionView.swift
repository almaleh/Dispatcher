//
//  QuestionView.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-23.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct QuestionContainer: View {
    
    @Binding var quizProcessor: QuizProcessor
    @Binding var isPresented: Bool
    
    // explains question after quiz is over
    @Binding var explanation: Bool
    
    init(quizProcessor: Binding<QuizProcessor>, isPresented: Binding<Bool>, explanation: Binding<Bool>) {
        self._quizProcessor = quizProcessor
        self._isPresented = isPresented
        self._explanation = explanation
        
        // ensure quiz is reset every launch
        if !explanation.wrappedValue {
            self.quizProcessor = QuizProcessor(questionsArray: Question.questionsArray(), questionNumber: 1)
        }
    }
    
    var body: some View {
        Group {
            if explanation {
                QuestionView(explanation: $explanation, quizProcessor: $quizProcessor)
            } else if quizProcessor.quizOver {
                QuizScoreSheet(quizProcessor: $quizProcessor,
                               isPresented: $isPresented)
            } else {
                QuestionView(explanation: .constant(false), quizProcessor: $quizProcessor)
            }
        }
    }
    
}

struct QuestionView: View {
    
    @State private var selectedAnswer: Int?
    private var answerWasSelected: Bool { selectedAnswer != nil }
    private var question: Question { quizProcessor.question }
    private var answers: [String] { question.answers }
    
    @Binding var explanation: Bool
    @Binding var quizProcessor: QuizProcessor
    
    var body: some View {
        VStack (alignment: .center, spacing: 10) {
            Text("Question \(quizProcessor.questionNumber)/10")
            Text(question.question)
                .font(.headline)
                .multilineTextAlignment(.center)
            ScrollView {
                Text(question.code)
                    .foregroundColor(.white)
                    .lineSpacing(3)
                    .font(.system(size: 14, design: .monospaced))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 500)
                    .padding([.leading, .trailing, .bottom])
                    .background(
                        Color.black.brightness(0.2)
                            .border(Color.black, width: 2)
                )
                    .cornerRadius(4)
            }
            Spacer(minLength: 0)
            if explanation {
                explanationStack
            } else {
                answerStack
            }
        }
        .padding()
    }
    
    var answerStack: some View {
        Group {
            VStack (spacing: 10) {
                ForEach(0..<answers.count, id: \.self) { idx in
                    QuestionButton(label: self.answers[idx],
                                   selectedAnswer: self.$selectedAnswer, id: idx)
                }
            }
            Button("Confirm") {
                self.quizProcessor.answered(with: self.selectedAnswer ?? 0)
                self.selectedAnswer = nil
            }
            .opacity(answerWasSelected ? 1.0 : 0.0)
            .font(.title)
        }
    }
    
    var explanationStack: some View {
        VStack (spacing: 20) {
            Text("The correct answer is: ")
            Text(question.answers[question.correctAnswer])
                .font(.headline)
                .padding(.bottom, 20)
            Text(question.explanation)
            Spacer(minLength: 0)
            Button("Dismiss") {
                self.explanation = false
            }
            .font(.title)
        }
        .multilineTextAlignment(.center)
        .frame(maxWidth: 330)
    }
}

struct QuizStartScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(explanation: .constant(false),
                     quizProcessor: .constant(QuizProcessor(questionsArray: Question.questionsArray(), questionNumber: 7)))
    }
}
