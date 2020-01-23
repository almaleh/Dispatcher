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
    
    init(_ type: TaskType, _ displayTime: Date?, _ startTime: Date, _ duration: Double, _ threadID: Int = 0) {
        self.type = type
        self.displayTime = displayTime
        self.startTime = startTime
        self.duration = duration
        self.threadID = threadID
    }
    
    init(_ type: TaskType, _ startTime: Date, _ duration: Double, _ threadID: Int = 0) {
        self.type = type
        self.displayTime = nil
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
        let blockPause = 0.5 // adjust as needed
        let statementPause = blockPause + 1.8
        let shortPause = 1.0
        let syncStart = Date().addingTimeInterval(syncStartDelay)
        
        tasks.append(Task(.statement(.sync), syncStart, duration))
        tasks.append(Task(.workBlock(.red, emojis.removeFirst()), syncStart, duration))
        
        let asyncStartStatement1 = Date().addingTimeInterval(syncStartDelay + duration) + statementPause
        let asyncStartBlock1 = Date().addingTimeInterval(syncStartDelay + duration) + blockPause
        tasks.append(Task(.statement(.async), asyncStartStatement1, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), asyncStartBlock1, duration))
        
        let asyncStartStatement2 = Date().addingTimeInterval(syncStartDelay + duration) + (statementPause)
        let asyncStartBlock2 = Date().addingTimeInterval(syncStartDelay + duration * 2 - blockPause)
        tasks.append(Task(.statement(.async), asyncStartStatement2, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), asyncStartBlock1, asyncStartBlock2, duration))
        
        tasks.append(Task(.statement(.done), asyncStartStatement2 + shortPause, duration))
        
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
        
        tasks.append(Task(.statement(.async), task1Start, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), task1Start, duration))
        
        let task2StartStatement = Date().addingTimeInterval(startDelay + 1.0) + statementPause
        let task2StartBlock = Date().addingTimeInterval(startDelay + 1.0) + blockPause
        
        tasks.append(Task(.statement(.async), task2StartStatement, duration))
        tasks.append(Task(.workBlock(.blue, emojis.removeFirst()), task2StartBlock, duration, 1))
        
        return tasks
    }
    
    
}
