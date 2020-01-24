//
//  QuestionView.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-23.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    
    let questionsArray: [Question] = sampleQuestionsArray
    var question: Question { questionsArray[questionNumber] }
    
    @State private var questionNumber: Int = 0
    @State private var selectedAnswer: Int = -1
    
    private var answerWasSelected: Bool { selectedAnswer != -1 }
    
    @Binding var isPresented: Bool
    @Binding var score: [Int: Int]
    
    var body: some View {
        VStack (alignment: .center, spacing: 20) {
            Text("Question \(questionNumber)/10")
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
                ForEach(0..<question.answers.count, id: \.self) { idx in
                    
                    QuestionButton(label: self.question.answers[idx],
                                   selectedAnswer: self.$selectedAnswer, id: idx)
                }
            }
            Spacer()
            Button("Confirm") {
                self.questionNumber += 1
                self.selectedAnswer = -1
            }
            .opacity(answerWasSelected ? 1.0 : 0.0)
            .font(.title)
        }
        .padding()
    }
}

struct QuizStartScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(isPresented: .constant(false), score: .constant([0:0]))
    }
}
