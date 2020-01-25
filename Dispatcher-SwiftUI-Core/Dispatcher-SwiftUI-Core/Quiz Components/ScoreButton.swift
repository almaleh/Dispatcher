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
    let action: (() -> Void)
    
    var body: some View {
        
        Button(action: {
            self.action()
        }) {
            HStack {
                Text("Q\(index + 1)")
                Spacer(minLength: 0)
                self.scoreImage(for: index + 1)
            }
            .font(.system(size: 22))
            .frame(maxWidth: 75)
        }
        
    }
    
    func scoreImage(for question: Int) -> AnyView {
        
        var green = Color.green
        var red = Color.red
        
        #if os(iOS)
            green = Color(UIColor.systemGreen)
            red = Color(UIColor.systemRed)
        #elseif os(OSX)
            green = Color(NSColor.systemGreen)
            red = Color(NSColor.systemRed)
        #endif
        
        let correct = quizProcessor.score[question] ?? false
        if correct {
            return AnyView(Image(systemName: "checkmark.circle.fill")
                .foregroundColor(green))
        } else {
            return AnyView(Image(systemName: "xmark.circle.fill")
                .foregroundColor(red))
        }
    }
}

struct ScoreButton_Previews: PreviewProvider {
    static var previews: some View {
        
        ScoreButton(index: 0,
                    quizProcessor: QuizScoreSheet_Previews.sampleQuiz,
                    action: {})
    }
}
