//
//  Task.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-23.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

enum TaskType {
    case workBlock(Color, String)
    case statement(DispatchType)
    case shadow
    
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
    
    // invisible thread remains on queue while real thread is shared
    var isShadowThreadTask: Bool {
        if case .workBlock(.purple, _) = self {
            return true
        } else if case .statement(.async) = self {
            return true
        } else if case .statement(.done) = self {
            return true
        } else if case .statement(.shadow) = self {
            return true
        } else {
            return false
        }
    }
}

struct Task {
    let taskType: TaskType
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
        self.taskType = type
        self.displayTime = displayTime
        self.startTime = startTime
        self.duration = duration
        self.threadID = threadID
    }
    
    init(_ type: TaskType, _ displayTime: Date, _ startTime: Date, _ duration: Double) {
        self.init(type, displayTime, startTime, duration, 0)
    }
    
    init(_ type: TaskType, _ startTime: Date, _ duration: Double, _ threadID: Int = 0) {
        self.init(type, nil, startTime, duration, threadID)
    }
}
