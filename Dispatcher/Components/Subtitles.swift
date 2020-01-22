//
//  Subtitles.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-21.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct Subtitles: View {

    @Binding var didStart: Bool
    @State private var textVisible = false
    var topic: Topic
    
    var startButtonText: String {
        "Replay"
    }
    
    var startButtonImage: String {
        "play.circle.fill"
    }
    
    var body: some View {
        ZStack {
            Button(action: {
                self.didStart = true
                self.textVisible = true
            }) {
                HStack {
                    Text(self.startButtonText)
                    Image(systemName: self.startButtonImage)
                }
                .font(.headline)
                .padding(8)
            }
            .opacity(textVisible ? 0.0 : 1.0)
            Text(topic.explanation)
                .opacity(textVisible ? 1.0 : 0.0)
                .padding(8)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .padding([.trailing, .leading, .top], 25)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                self.textVisible = false
            }
        }
    }
    
}


