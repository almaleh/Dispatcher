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
    
    var body: some View {
        HStack(spacing: spacing) {
            if currentTopic == .sync || currentTopic == .async {
                ForEach(0..<currentTopic.numberOfQueues, id: \.self) { num in
                    num == 0 ? Queue(topic: self.currentTopic, type: .main, threads: self.$mainThreads)
                        : Queue(topic: self.currentTopic, type: .global, threads: self.$otherThreads)
                }
                .id(UUID())
            } else if currentTopic == .serial {
                ForEach(0..<currentTopic.numberOfQueues, id: \.self) { num in
                    num == 0 ? Queue(topic: .serial, type: .main, threads: self.$mainThreads)
                        : Queue(topic: .serial, type: .privateSerial, threads: self.$otherThreads)
                }
                .id(UUID())
            } else if currentTopic == .concurrent {
                ForEach(0..<currentTopic.numberOfQueues, id: \.self) { num in
                    num == 0 ? Queue(topic: .concurrent, type: .main, threads: self.$mainThreads)
                        : Queue(topic: .concurrent, type: .privateConcurrent, threads: self.$otherThreads)
                }
                .id(UUID())
            }
            if currentTopic == .serial {
                Spacer()
            }
        }
        .onAppear {
            self.increaseThreadCount()
        }
        .id(UUID()) // force animation restart
    }
    
    func increaseThreadCount() {
        self.otherThreads = 0
        self.workItem?.cancel()
        self.workItem = nil
        let workItem = DispatchWorkItem {
            self.otherThreads = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem)
        self.workItem = workItem
    }
}

struct Scheduler_Previews: PreviewProvider {
    
    static var previews: some View {
        Scheduler(topic: 0, didStart: .constant(false))
    }
}
