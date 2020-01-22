//
//  Scheduler.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct Scheduler: View {
    
    private let spacing: CGFloat = 25
    private let topic: Int
    
    @State private var mainThreads = 1
    @State private var otherThreads = 0
    @State private var workItem: DispatchWorkItem?
    
    @Binding var didStart: Bool
    
    init(topic: Int, didStart: Binding<Bool>) {
        self.topic = topic
        self._didStart = didStart
    }
    
    var currentTopic: Topic {
        return Topic.allCases[self.topic]
    }
    
    var tasks: [Task] {
        return getTasks(for: Topic.allCases[topic])
    }
    
    var body: some View {
        ZStack (alignment: .bottom) {
            HStack(spacing: spacing) {
                if currentTopic == .sync || currentTopic == .async {
                    ForEach(0..<currentTopic.numberOfQueues, id: \.self) { num in
                        num == 0 ? Queue(topic: self.currentTopic, type: .main, tasks: self.tasks, threads: self.$mainThreads)
                            .zIndex(1)
                            : Queue(topic: self.currentTopic, type: .global, tasks: self.tasks, threads: self.$otherThreads)
                                .zIndex(0)
                    }
                    .id(UUID())
                } else if currentTopic == .serial {
                    ForEach(0..<currentTopic.numberOfQueues, id: \.self) { num in
                        num == 0 ? Queue(topic: .serial, type: .main, tasks: self.tasks, threads: self.$mainThreads)
                            .zIndex(1)
                            : Queue(topic: .serial, type: .privateSerial, tasks: self.tasks, threads: self.$otherThreads)
                                .zIndex(0)
                    }
                    .id(UUID())
                } else if currentTopic == .concurrent {
                    ForEach(0..<currentTopic.numberOfQueues, id: \.self) { num in
                        num == 0 ? Queue(topic: .concurrent, type: .main, tasks: self.tasks, threads: self.$mainThreads)
                            .zIndex(1)
                            : Queue(topic: .concurrent, type: .privateConcurrent, tasks: self.tasks, threads: self.$otherThreads)
                                .zIndex(0)
                    }
                    .id(UUID())
                }
            }
            .onAppear {
                self.increaseThreadCount()
            }
                .id(UUID()) // force animation restart
            
            VStack (spacing: 0.0) {
                Subtitles(didStart: $didStart, topic: Topic.allCases[topic])
                CodeConsole(tasks: tasks)
                    .frame(maxHeight: 100)
            }
                // This is a 'hack' to force animation restart, not proud of it
                .opacity(didStart ? 1.0 : 0.99)
                .padding(.bottom, -10)
        }
    }
    
    func increaseThreadCount() {
        self.otherThreads = 0
        self.workItem?.cancel()
        self.workItem = nil
        let workItem = DispatchWorkItem {
            self.otherThreads = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
        self.workItem = workItem
    }
    
    func getTasks(for topic: Topic) -> [Task] {
        switch topic {
        case .sync: return TaskGenerator.createSyncTasks()
        default: return TaskGenerator.createSyncTasks()
        }
    }
}

struct Scheduler_Previews: PreviewProvider {
    
    static var previews: some View {
        Scheduler(topic: 0, didStart: .constant(false))
    }
}
