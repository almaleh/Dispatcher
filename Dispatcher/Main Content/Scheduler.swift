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
                    Queue(type: num == 0 ? .main :
                        QueueType.global, threads: num + 1)
                }
            } else if currentTopic == .serial {
                ForEach(0..<currentTopic.numberOfQueues, id: \.self) { num in
                    Queue(type: num == 0 ? .main :
                        QueueType.privateSerial, threads: 1)
                }
            } else if currentTopic == .concurrent {
                ForEach(0..<currentTopic.numberOfQueues, id: \.self) { num in
                    Queue(type: num == 0 ? .main :
                        QueueType.privateConcurrent, threads: num + 1)
                }
            }
            if currentTopic == .serial {
                Spacer()
            }
        }
    }
}

struct Scheduler_Previews: PreviewProvider {
    
    static var previews: some View {
        Scheduler(topic: 0, didStart: .constant(false))
    }
}
