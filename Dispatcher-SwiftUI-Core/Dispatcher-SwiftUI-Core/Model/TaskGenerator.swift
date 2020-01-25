//
//  TaskGenerator.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-20.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

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
        
        tasks.append(Task(.statement(.shadow), syncStart, duration))
        tasks.append(Task(.statement(.sync), syncStart, duration))
        tasks.append(Task(.workBlock(.red, emojis.removeFirst()), syncStart, duration))
        
        let asyncStartBlock1 = Date().addingTimeInterval(syncStartDelay + duration)
        tasks.append(Task(.workBlock(.purple, emojis.removeFirst()), Date(), asyncStartBlock1, duration))
        
        let doneStatement = Date().addingTimeInterval(syncStartDelay + duration) + statementPause
        tasks.append(Task(.statement(.done), doneStatement + duration - shortPause, duration))
        
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
        
        tasks.append(Task(.statement(.done), asyncStartStatement2 + duration - 1.0, duration))
        
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
