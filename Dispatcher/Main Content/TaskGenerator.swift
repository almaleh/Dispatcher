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
        
        let syncStart = Date().addingTimeInterval(3)
        tasks.append(Task(type: .workBlock(.red), startTime: syncStart, duration: duration))
        tasks.append(Task(type: .statement(.sync), startTime: syncStart, duration: duration))
        
        
        let asyncStart = Date().addingTimeInterval(10)
        tasks.append(Task(type: .workBlock(.blue), startTime: asyncStart, duration: duration))
        tasks.append(Task(type: .statement(.async), startTime: asyncStart, duration: duration))
        
        return tasks
    }
    
    
}
