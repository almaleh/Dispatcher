//
//  Thread.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-17.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct Thread: View {
    
    @State private var workTasks = [Task]()
    @State private var emojiOpacity: Double = 0.0
    @State private var emojiScale: CGFloat = 0.5
    @State private var threadLength: CGFloat = 0.0
    @State private var taskOpacity = 0.0
    
    let topic: Topic
    let type: QueueType
    
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
                    ForEach(0..<workTasks.count, id: \.self) { idx in
                        self.getTask(at: idx)
                            .padding([.top, .bottom], 5)
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
            self.addTasksForType(self.type)
        }
    }
    
    func addTasksForType(_ type: QueueType) {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            switch type {
            case .main:
                self.workTasks.append(.workBlock(WorkBlock(isCollapsing: true)))
//                self.workTasks.append(.statement(Statement(type: .sync)))
            default: break
            }
        }
    }
    
    func getTask(at index: Int) -> AnyView {
        switch workTasks[index] {
        case .workBlock(let block): return AnyView(block)
        case .statement(let statement): return AnyView(statement)
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
        Thread(topic: .sync, type: .main)
    }
}
