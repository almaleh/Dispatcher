//
//  TaskGenerator.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-20.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

enum TaskType {
    case workBlock(Color)
    case statement(DispatchType)
    
    var isMainThreadTask: Bool {
        if case .workBlock(.blue) = self {
            return false
        } else {
            return true 
        }
    }
    
    var isMainThreadOnly: Bool {
        if case .workBlock = self {
            return false
        } else {
            return true
        }
    }
}

struct Task {
    let type: TaskType
    let startTime: Date
    let duration: Double
}

enum TaskGenerator {
    
    
    static func createSyncTasks() -> [Task] {
        
        var tasks = [Task]()
        let duration: Double = 5.0
        
        let syncStartDelay = 4.0
        let blockPause = 0.5 // adjust as needed
        let statementPause = blockPause + 1.5
        let syncStart = Date().addingTimeInterval(syncStartDelay)
        tasks.append(Task(type: .statement(.sync), startTime: syncStart, duration: duration))
        tasks.append(Task(type: .workBlock(.red), startTime: syncStart, duration: duration))
        
        
        let asyncStart = Date().addingTimeInterval(syncStartDelay + duration)
        tasks.append(Task(type: .statement(.async), startTime: asyncStart + statementPause, duration: duration))
        tasks.append(Task(type: .workBlock(.blue), startTime: asyncStart + blockPause, duration: duration))
        
        return tasks
    }
    
    
}
