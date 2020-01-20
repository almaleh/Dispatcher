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
    
    let topic: Topic
    let type: QueueType
    
    private let width: CGFloat = 110.0
    @Binding var threads: Int
    @State private var showThreads = false
    
    var body: some View {
        VStack {
            Text(type.rawValue)
                .frame(maxHeight: 15)
                .frame(minWidth: width + 40.0)
            ZStack {
                type.color
                    .clipShape(Rectangle())
                    .opacity(0.6)
                    .frame(minWidth: width)
                if type == .main || showThreads {
                    HStack {
                        ForEach(0..<threads, id: \.self) { num in
                            Thread(topic: self.topic, type: self.type)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: width * CGFloat(threads))
        .frame(minWidth: width)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showThreads = true
            }
        }
    }
}

struct Queue_Previews: PreviewProvider {
    static var previews: some View {
        Queue(topic: .sync, type: .main, threads: .constant(1))
    }
}
