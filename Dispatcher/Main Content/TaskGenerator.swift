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
    
    var startDelay: TimeInterval {
        max(startTime.timeIntervalSince(Date()), 0.0)
    }
}

enum TaskGenerator {
    
    private static let baseEmojis = ["🥱", "🤯", "🤪", "😵", "🐮", "🐵", "👻", "🐔"]
    
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
    
    
}
