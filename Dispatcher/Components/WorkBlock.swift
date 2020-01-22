//
//  WorkBlock.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct WorkBlock: View {
    
    
    @State private var progress: CGFloat = 1.0
    @State private var borderOpacity: Double = 1.0
    
    private let task: Task
    private let possibleBlockColors: [Color] = [.purple]
    
    private let color: Color
    private let emoji: String
    
    private var startTime: Date { task.startTime }
    private var taskDuration: Double { task.duration * 0.8 }
    
    var body: some View {
        return ZStack {
            color
                .frame(width: 60, height: 150 * progress)
                .border(Color.yellow.opacity(borderOpacity), width: 3)
                .onAppear {
                    self.startTask()
            }
            .overlay(
                Text(emoji)
                    .font(.largeTitle)
            )
                .clipped()
        }
    }
    
    init (task: Task) {
        self.task = task
        if case .workBlock(let color, let emoji) = task.type {
            self.color = color
            self.emoji = emoji
        } else {
            self.color = .red
            self.emoji = "🐷"
        }
        _progress = State(initialValue: 0.0)
    }
    
    func startTask() {
        let startDelay = task.startDelay
        
        withAnimation(Animation
            .easeInOut(duration: self.taskDuration * 0.2)
            .delay(startDelay)) {
                self.progress = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + startDelay) {
            withAnimation(Animation
                .linear(duration: self.taskDuration * 0.65)
                .delay(self.taskDuration * 0.3)) {
                    self.progress = 0.0
            }
            withAnimation(Animation
                .linear(duration: self.taskDuration / 4)
                .delay(self.taskDuration * 0.3 + (3 * self.taskDuration / 4))) {
                    self.borderOpacity = 0.0
            }
        }
    }
}

struct WorkBlock_Previews: PreviewProvider {
    static var previews: some View {
        WorkBlock(task: Task(type: .workBlock(.red, "🐶"), startTime: Date(), duration: 1))
    }
}
