//
//  Queue.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-17.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

enum QueueType: String, CaseIterable {
    case main = "Main Queue"
    case global = "Global Concurrent"
    case privateSerial = "Private Serial"
    case privateConcurrent = "Private Concurrent"
    
    var color: Color {
        switch self {
        case .main: return .green
        case .global: return .blue
        case .privateSerial: return .purple
        case .privateConcurrent: return Color(red: 157/255, green: 187/255, blue: 174/255)
        }
    }
}

struct Queue: View {
    
    let topic: Topic
    let type: QueueType
    let tasks: [Task]
    var allTasks = [Task]() // stores sync task
    
    private let width: CGFloat = 110.0
    @State private var threads: Int = 0
    @State private var showThreads = false
    @State private var syncInProgress = false
    @State private var workItem: DispatchWorkItem?
    
    var syncQueuePaddingEdge: Edge.Set {
        return type == .main ? .trailing : .leading
    }
    
    var syncQueuePadding: CGFloat {
        guard syncInProgress else { return 0.0 }
        return type == .main ? width * -0.85 : width * -0.35
    }
    
    @State private var syncThreadOffset: CGFloat = 0.0
    
    var body: some View {
        VStack {
            Text(type.rawValue)
                .frame(maxHeight: 15)
                .frame(minWidth: width + 40.0)
            ZStack {
                type.color
                    .clipShape(Rectangle())
                    .opacity(0.5)
                    .frame(minWidth: width)
                    .padding(syncQueuePaddingEdge, syncQueuePadding)
                if type == .main || showThreads {
                    ZStack (alignment: .leading) {
                        HStack {
                            if self.topic == .sync && type == .main {
                                Spacer()
                            }
                            ForEach(0..<threads, id: \.self) { num in
                                self.createThreads(id: num)
                                    .frame(width: self.width)
                            }
                        }
                        if self.topic == .sync && type == .main {
                            createMainThread(id: 0, isShadow: true)
                                .frame(width: self.width)
                                .offset(x: width * 0.05, y: 0)
                        }
                    }
                    .padding(syncQueuePaddingEdge, syncQueuePadding)
                }
            }
            .offset(x: self.syncThreadOffset, y: 0)
        }
        .frame(maxWidth: width * CGFloat(threads))
        .frame(minWidth: width)
        .onAppear {
            self.processSyncTask()
            self.increaseThreadCount()
            let threadsDelay = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + threadsDelay) {
                self.showThreads = true
            }
        }
    }
    
    // Animates the queues to share thread
    func processSyncTask() {
        for task in allTasks {
            if case .workBlock(.red, _) = task.taskType {
                
                let animDuration = 1.75
                let taskStart = task.startTime.timeIntervalSince(Date()) - animDuration
                
                DispatchQueue.main.asyncAfter(deadline: .now() + taskStart) {
                    withAnimation(.easeInOut(duration: animDuration)) {
                        self.syncInProgress = true
//                        self.syncThreadOffset = self.type == .main ?
//                            self.width * 0.75 : 0.0
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + taskStart + task.duration) {
                    withAnimation(.easeInOut(duration: animDuration)) {
                        self.syncInProgress = false
                        self.syncThreadOffset = 0.0
                    }
                }
            }
        }
    }
    
    func increaseThreadCount() {
        guard type != .main else { return }
        threads = 0
        workItem?.cancel()
        workItem = nil
        
        let workItem = DispatchWorkItem {
            withAnimation(.easeOut(duration: 0.35)) {
                switch self.topic {
                case .concurrent:
                    self.threads = 2
                default: self.threads = 1
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: workItem)
        self.workItem = workItem
    }
    
    func createThreads(id: Int) -> some View {
        ZStack {
            if self.topic == .sync && type == .main {
                createMainThread(id: id, isShadow: false)
            } else {
                Thread(topic: self.topic, type: self.type, tasks: self.tasks, threadID: id)
            }
        }
    }
    
    func createMainThread(id: Int, isShadow: Bool) -> some View {
        let tasks = self.tasks.filter { isShadow ? $0.taskType.isShadowThreadTask : !$0.taskType.isShadowThreadTask }
        return Thread(topic: self.topic, type: self.type, tasks: tasks, threadID: id, isShadow: isShadow)
    }
    
    init(topic: Topic, type: QueueType, tasks: [Task]) {
        self.topic = topic
        self.type = type
        // only register the tasks meant for this queue
        self.allTasks = tasks.filter { task in
            if type == .main {
                return task.taskType.isMainThreadTask
            } else {
                // include both types of blocks, sync & async
                return task.taskType.isWorkBlock
            }
        }
        self.tasks = tasks.filter { task in
            if type == .main {
                return task.taskType.isMainThreadTask
            } else {
                return !task.taskType.isMainThreadTask
            }
        }
        let threads = type == .main ? 1 : 0
        _threads = State(initialValue: threads)
    }
}

struct Queue_Previews: PreviewProvider {
    static var previews: some View {
        return Queue(topic: .sync, type: .main,
                     tasks: TaskGenerator.createSyncTasks())
    }
}
