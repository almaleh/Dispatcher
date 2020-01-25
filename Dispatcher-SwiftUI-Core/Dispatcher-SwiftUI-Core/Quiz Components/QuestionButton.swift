//
//  QuestionButton.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-23.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct QuestionButton: View {
    
    let label: String
    
    @Binding var selectedAnswer: Int?
    let id: Int
    
    var foreground: Color {
        return selectedAnswer == id ? .white : Color(UIColor.label)
    }
    
    var background: Color {
        return selectedAnswer == id ? Color(UIColor.systemGray) : Color(UIColor.systemGray6)
    }
    
    var body: some View {
        Button(action: {
            self.selectedAnswer = self.id
        }) {
            Text(self.label)
                .foregroundColor(foreground)
                .multilineTextAlignment(.center)
                .padding(10)
                .frame(maxWidth: 340)
                .background(background)
                .cornerRadius(12)
        }
    }
}

struct QuestionButton_Previews: PreviewProvider {
    
    static let testLabel = "Does not compile: cannot convert DispatchQueue to UIImage?"
    
    static var previews: some View {
        QuestionButton(label: "Does not compile: cannot convert DispatchQueue to UIImage?",
                       selectedAnswer: .constant(0), id: 0)
    }
}
