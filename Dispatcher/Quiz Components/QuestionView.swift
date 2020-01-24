//
//  QuestionView.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-23.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    
    let questionNumber: Int
    let question: Question
    @Binding var score: [Int: Int]
    
    var body: some View {
        VStack (alignment: .center, spacing: 30) {
            Text("Question \(questionNumber)/10")
            Text(question.question)
                .font(.title)
                .multilineTextAlignment(.center)
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
            Spacer()
            ForEach(0..<question.answers.count, id: \.self) { idx in
                
                Text(self.question.answers[idx])
            }
            
        }
        .padding()
    }
}

struct QuizStartScreen_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(questionNumber: 1, question: sampleQuestion, score: .constant([0:0]))
    }
}
