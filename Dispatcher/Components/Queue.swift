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
        case .global: return .purple
        case .privateSerial: return .blue
        case .privateConcurrent: return .red
        }
    }
}

enum Task {
    case workBlock(WorkBlock)
    case statement(Statement)
}

struct Queue: View {
    
    let type: QueueType
    var threads: Int
    
    var body: some View {
        VStack {
            Text(type.rawValue)
            ZStack {
                type.color
                    .clipShape(Rectangle())
                    .opacity(0.6)
                HStack {
                    ForEach(0..<threads, id: \.self) { num in
                        Thread(type: self.type)
                    }
                }
            }
        }
        .frame(maxWidth: 110 * CGFloat(threads))
    }
}

struct Queue_Previews: PreviewProvider {
    static var previews: some View {
        Queue(type: .privateConcurrent, threads: 1)
    }
}
