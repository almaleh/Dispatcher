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
    let taskType: TaskType
    let queueType: QueueType?
    let displayTime: Date?
    let startTime: Date
    let duration: Double
    let threadID: Int
    
    var displayDelay: TimeInterval {
        guard let displayTime = displayTime else { return startDelay }
        return max(displayTime.timeIntervalSince(Date()), 0.0)
    }
    
    var startDelay: TimeInterval {
        max(startTime.timeIntervalSince(Date()), 0.0)
    }
    
    init(_ type: TaskType, _ queueType: QueueType?, _ displayTime: Date?, _ startTime: Date, _ duration: Double, _ threadID: Int = 0) {
        self.taskType = type
        self.queueType = queueType
        self.displayTime = displayTime
        self.startTime = startTime
        self.duration = duration
        self.threadID = threadID
    }
    
    init(_ type: TaskType, _ queueType: QueueType?, _ displayTime: Date? = nil, _ startTime: Date, _ duration: Double) {
        self.init(type, queueType, displayTime, startTime, duration, 0)
    }
    
    init(_ type: TaskType, _ queueType: QueueType?, _ startTime: Date, _ duration: Double) {
        self.init(type, queueType, nil, startTime, duration, 0)
    }
    
    init(_ type: TaskType, _ displayTime: Date, _ startTime: Date, _ duration: Double) {
        self.init(type, nil, displayTime, startTime, duration, 0)
    }
    
    init(_ type: TaskType, _ startTime: Date, _ duration: Double, _ threadID: Int = 0) {
        self.init(type, nil, nil, startTime, duration, threadID)
    }
}

enum TaskGenerator {
    
    private static let baseEmojis = ["⚾️", "🥑", "🤪", "🚚", "🐮", "⛸", "👻", "🐔"]
    
    static func createSyncTasks() -> [Task] {
        
        var emojis = baseEmojis.shuffled()
        var tasks = [Task]()
        let duration: Double = 7.0
        
        let syncStartDelay = 4.0
        let blockPause = 0.5 // adjust as needed
        let statementPause = blockPause + 0.9
        let shortPause = 1.0
        
        let syncStart = Date().addingTimeInterval(syncStartDelay)
        
        tasks.append(Task(.statement(.sync), .main, syncStart, duration))
        tasks.append(Task(.workBlock(.red, emojis.removeFirst()), .main, syncStart, duration))
        
        let asyncStartStatement1 = Date().addingTimeInterval(syncStartDelay + duration) + statementPause
        let asyncStartBlock1 = Date().addingTimeInterval(syncStartDelay + duration)
        tasks.append(Task(.workBlock(.purple, emojis.removeFirst()), .main, Date(), asyncStartBlock1, duration))
        
        tasks.append(Task(.statement(.done), asyncStartStatement1 + shortPause * 2.0, duration))
        
        return tasks
    }
    
    static func createAsyncTasks() -> [Task] {
        
        var emojis = baseEmojis.shuffled()
        var tasks = [Task]()
        let duration: Double = 7.0
        
        let startDelay = 4.5
        let blockPause = 0.75 // adjust as needed
        let statementPause = blockPause + 0.25
        
        let asyncStartStatement1 = Date().addingTimeInterval(startDelay)
        tasks.append(Task(.statement(.async), asyncStartStatement1, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), asyncStartStatement1, duration))
        
        let asyncStartStatement2 = asyncStartStatement1 + statementPause
        tasks.append(Task(.workBlock(.purple, emojis.removeFirst()), asyncStartStatement1 + statementPause, asyncStartStatement1, duration))
        
        tasks.append(Task(.statement(.done), asyncStartStatement2 + 1.5, duration))
        
        return tasks
    }
    
    static func createConcurrentTasks() -> [Task] {
        
        var emojis = baseEmojis.shuffled()
        var tasks = [Task]()
        let duration: Double = 7.0
        
        let startDelay = 4.5
        let blockPause = 0.75 // adjust as needed
        let statementPause = blockPause + 0.25
        
        let task1Start = Date().addingTimeInterval(startDelay)
        tasks.append(Task(.statement(.async), task1Start, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), task1Start, duration))
        
        let task2StartStatement = Date().addingTimeInterval(startDelay) + statementPause
        let task2StartBlock = Date().addingTimeInterval(startDelay) + blockPause
        
        tasks.append(Task(.statement(.async), task2StartStatement, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), task2StartBlock, duration, 1))
        
        tasks.append(Task(.statement(.done), task2StartStatement + 1.5, duration))
        
        return tasks
    }
    
    
    static func createSerialTasks() -> [Task] {
        
        var emojis = baseEmojis.shuffled()
        var tasks = [Task]()
        let duration: Double = 7.0
        
        let startDelay = 4.5
        let blockPause = 0.75 // adjust as needed
        let statementPause = blockPause + 0.25
        let shortPause = 1.0
        
        let asyncStartStatement1 = Date().addingTimeInterval(startDelay)
        tasks.append(Task(.statement(.async), asyncStartStatement1, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), asyncStartStatement1, duration))
        
        let asyncStartStatement2 = asyncStartStatement1 + statementPause
        let asyncStartBlock2 = Date().addingTimeInterval(startDelay + duration - shortPause * 2.5)
        
        tasks.append(Task(.statement(.async), asyncStartStatement2, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), asyncStartStatement1 + statementPause, asyncStartBlock2, duration))
        
        
        let asyncStartStatement3 = asyncStartStatement2 + statementPause
        let asyncStartBlock3 = Date().addingTimeInterval(startDelay + duration * 2 - shortPause * 5)
        
        tasks.append(Task(.statement(.async), asyncStartStatement3, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), asyncStartStatement2 + statementPause, asyncStartBlock3, duration))
        
        tasks.append(Task(.statement(.done), asyncStartStatement2 + 1.5, duration))
        
        return tasks
    }
}
