//
//  ScoreButton.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-25.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct ScoreButton: View {
    
    let index: Int
    let quizProcessor: QuizProcessor
    @State private var explanationPresented = false
    
    var body: some View {
        
        Button(action: {
            self.explanationPresented = true
        }) {
            HStack {
                Text("Q\(index + 1)")
                Spacer(minLength: 0)
                self.scoreImage(for: index)
            }
            .font(.system(size: 22))
            .frame(maxWidth: 75)
        }
        .alert(isPresented: self.$explanationPresented) {
            Alert(title: Text("Question \(index + 1)"), message: Text(quizProcessor.questionsArray[index].explanation))
        }
        
    }
    
    func scoreImage(for question: Int) -> AnyView {
        let correct = quizProcessor.score[question] ?? false
        if correct {
            return AnyView(Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green))
        } else {
            return AnyView(Image(systemName: "xmark.circle.fill")
                .foregroundColor(.red))
        }
    }
}

struct ScoreButton_Previews: PreviewProvider {
    static var previews: some View {
        
        ScoreButton(index: 0,
                    quizProcessor: QuizScoreSheet_Previews.sampleQuiz)
    }
}
