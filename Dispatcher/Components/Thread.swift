//
//  Thread.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-17.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct Thread: View {
    
    @State private var emojiOpacity: Double = 0.0
    @State private var emojiScale: CGFloat = 0.5
    @State private var threadLength: CGFloat = 0.0
    @State private var taskOpacity = 0.0
    
    let topic: Topic
    let type: QueueType
    let tasks: [Task]
    
    var body: some View {
        VStack {
            Text("🧵")
                .font(.largeTitle)
                .padding(.bottom, -10)
                .opacity(emojiOpacity)
                .animation(.default)
                .scaleEffect(emojiScale)
                .animation(
                    Animation.interpolatingSpring(mass: 0.5, stiffness: 35, damping: 15, initialVelocity: 20)
            )
            ZStack (alignment: .top) {
                WavyLine(threadLength: threadLength)
                    .stroke(Color.yellow, lineWidth: 3)
                    .animation(Animation
                        .easeInOut(duration: 1.5)
                        .delay(0.5))
                VStack (alignment: .center) {
                    ForEach(0..<tasks.count, id: \.self) { idx in
                        self.getTask(at: idx)
                            .opacity(self.taskOpacity)
                            .onAppear {
                                withAnimation(.default) {
                                    self.taskOpacity = 1.0
                                }
                        }
                    }
                }
            }
        }
        .padding(20)
        .onAppear {
            self.unrollThread()
        }
    }
    
    func getTask(at index: Int) -> AnyView {
        let task = tasks[index]
        
        switch task.type {
        case .workBlock(let color):
            return AnyView(WorkBlock(startTime: task.startTime, taskDuration: task.duration, color: color))
        case .statement(let type):
            return AnyView(Statement(startTime: task.startTime, type: type, duration: task.duration))
        }
    }
    
    func unrollThread() {
        self.emojiOpacity = 1.0
        self.emojiScale = 1.0
        self.threadLength = 1
    }
}

struct Thread_Previews: PreviewProvider {
    static var previews: some View {
        Thread(topic: .sync, type: .main, tasks: TaskGenerator.createSyncTasks())
    }
}
