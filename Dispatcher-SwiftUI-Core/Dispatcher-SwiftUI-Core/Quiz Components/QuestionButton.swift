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
        var color = Color.white
        #if os(iOS)
            color = Color(UIColor.label)
        #elseif os(OSX)
            color = Color(NSColor.labelColor)
        #endif
        return selectedAnswer == id ? .white : color
    }
    
    var background: Color {
        var darkGray = Color.white
        var lightGray = Color.white
        
        #if os(iOS)
            darkGray = Color(UIColor.systemGray)
            lightGray = Color(UIColor.systemGray6)
        #elseif os(OSX)
            darkGray = Color(NSColor.selectedTextBackgroundColor)
            lightGray = Color(NSColor.systemGray)
        #endif
        
        return selectedAnswer == id ? darkGray : lightGray
    }
    
    var body: some View {
        Button(action: {
            self.selectedAnswer = self.id
        }) {
            Text(self.label)
                .foregroundColor(foreground)
                .multilineTextAlignment(.center)
                .padding(8)
                .frame(maxWidth: 350)
                .background(background)
                .cornerRadius(12)
        }
    }
}

struct QuestionButton_Previews: PreviewProvider {
    
    static let testLabel = "Does not compile: cannot convert DispatchQueue to UIImage? Does not compile: cannot convert DispatchQueue to UIImage?"
    
    static var previews: some View {
        QuestionButton(label: testLabel,
                       selectedAnswer: .constant(0), id: 0)
    }
}
