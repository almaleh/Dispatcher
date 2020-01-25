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
    @State private var visibleTasks = [Task]()
    
    let topic: Topic
    let type: QueueType
    let tasks: [Task]
    let isShadow: Bool
    
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
                    ForEach(0..<visibleTasks.count, id: \.self) { idx in
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
            
            var delay = 0.0
            
            if self.topic == .sync && self.type != .main || self.isShadow {
                delay = 999
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.unrollThread()
            }
            
            // Delay before showing tasks
            let taskDisplayDelay = self.topic == .async || self.topic == .concurrent ? 0.5 : 1.5
            DispatchQueue.main.asyncAfter(deadline: .now() + taskDisplayDelay) {
                self.visibleTasks = self.tasks
            }
        }
    }
    
    func getTask(at index: Int) -> AnyView {
        let task = visibleTasks[index]
        switch task.taskType {
        case .workBlock:
            return AnyView(WorkBlock(task: task))
        case .statement(let type):
            return AnyView(Statement(type: type, task: task))
        case .shadow:
            return AnyView(Statement(type: .shadow, task: task))
        }
    }
    
    func unrollThread() {
        self.emojiOpacity = 1.0
        self.emojiScale = 1.0
        self.threadLength = 0.7
    }
    
    init(topic: Topic, type: QueueType, tasks: [Task], threadID: Int, isShadow: Bool = false) {
        self.topic = topic
        self.type = type
        self.tasks = tasks.filter { $0.threadID == threadID }
        self.isShadow = isShadow
    }
}

struct Thread_Previews: PreviewProvider {
    static var previews: some View {
        Thread(topic: .sync, type: .main, tasks: TaskGenerator.createSyncTasks(), threadID: 0)
    }
}
