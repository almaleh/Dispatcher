//
//  TaskGenerator.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-20.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

enum TaskType {
    case workBlock(Color, String)
    case statement(DispatchType)
    
    var isMainThreadTask: Bool {
        if case .workBlock(.blue, _) = self {
            return false
        } else {
            return true 
        }
    }
    
    var isWorkBlock: Bool {
        if case .workBlock = self {
            return true
        } else {
            return false
        }
    }
}

struct Task {
    let type: TaskType
    let startTime: Date
    let duration: Double
    let threadID: Int
    
    var startDelay: TimeInterval {
        max(startTime.timeIntervalSince(Date()), 0.0)
    }
    
    init(type: TaskType, startTime: Date, duration: Double, threadID: Int = 0) {
        self.type = type
        self.startTime = startTime
        self.duration = duration
        self.threadID = threadID
    }
}

enum TaskGenerator {
    
    private static let baseEmojis = ["⚾️", "🥑", "🤪", "🚚", "🐮", "⛸", "👻", "🐔"]
    
    static func createSyncTasks() -> [Task] {
        
        var emojis = baseEmojis.shuffled()
        var tasks = [Task]()
        let duration: Double = 7.0
        
        let syncStartDelay = 4.5
        let blockPause = 1.5 // adjust as needed
        let statementPause = blockPause + 1.75
        let syncStart = Date().addingTimeInterval(syncStartDelay)
        
        tasks.append(Task(type: .statement(.sync), startTime: syncStart, duration: duration))
        tasks.append(Task(type: .workBlock(.red, emojis.removeFirst()), startTime: syncStart, duration: duration))
        
        
        let asyncStart = Date().addingTimeInterval(syncStartDelay + duration)
        tasks.append(Task(type: .statement(.async), startTime: asyncStart + statementPause, duration: duration))
        tasks.append(Task(type: .workBlock(.blue, emojis.removeFirst()), startTime: asyncStart + blockPause, duration: duration))
        
        return tasks
    }
    
    static func createAsyncTasks() -> [Task] {
        
        var emojis = baseEmojis.shuffled()
        var tasks = [Task]()
        let duration: Double = 7.0
        
        let startDelay = 4.5
        let blockPause = 1.5 // adjust as needed
        let statementPause = blockPause + 1.75
        let task1Start = Date().addingTimeInterval(startDelay)
        
        tasks.append(Task(type: .statement(.async), startTime: task1Start, duration: duration))
        tasks.append(Task(type: .workBlock(.blue, emojis.removeFirst()), startTime: task1Start, duration: duration))
        
        let task2Start = Date().addingTimeInterval(startDelay + 1.0)
        tasks.append(Task(type: .statement(.async), startTime: task2Start + statementPause, duration: duration))
        tasks.append(Task(type: .workBlock(.blue, emojis.removeFirst()), startTime: task2Start + blockPause, duration: duration, threadID: 1))
        
        return tasks
    }
    
    
}
