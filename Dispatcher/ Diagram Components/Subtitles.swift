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
    @State private var textVisible = true
    @State private var workItem: DispatchWorkItem?
    
    var topic: Topic
    
    var startButtonText: String {
        "Replay"
    }
    
    var startButtonImage: String {
        "play.circle.fill"
    }
    
    var body: some View {
        scheduleButtonToAppear()
        return ZStack {
            Button(action: {
                self.didStart = !self.didStart
                self.textVisible = true
            }) {
                HStack {
                    Text(self.startButtonText)
                    Image(systemName: self.startButtonImage)
                }
                .font(.title)
                .padding(8)
            }
            .opacity(textVisible ? 0.0 : 1.0)
            Text(topic.explanation)
                .opacity(textVisible ? 1.0 : 0.0)
                .padding(8)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding([.trailing, .leading], 4)
        .background(Color(UIColor.systemBackground))
    }
    
    func scheduleButtonToAppear() {
        DispatchQueue.main.async {
            self.workItem?.cancel()
            self.workItem = nil
            let workItem = DispatchWorkItem {
                if self.textVisible { self.textVisible = false }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 15, execute: workItem)
            self.workItem = workItem
        }
    }
    
}


