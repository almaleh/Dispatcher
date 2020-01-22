//
//  CodeConsole.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-20.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct CodeConsole: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    private let numberOfVisibleLines = 5
    private let tasks: [Task]
    
    @State private var lines = ["Awaiting tasks"]
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            ForEach (0..<lines.count, id: \.self) { index in
                Text(self.lines[index])
                    .foregroundColor(.white)
                    .font(.system(size: 14, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .bottom], 1)
            }
        }
        .padding([.trailing, .leading], 5)
        .background(
            Color.black.brightness(0.2)
                .border(Color.black, width: 2)
        )
            .cornerRadius(3)
            .onAppear {
                self.tasks.forEach { self.processTask($0) }
        }
    }
    
    init(tasks: [Task]) {
        self.tasks = tasks.filter { $0.type.isWorkBlock }
    }
    
    func processTask(_ task: Task) {
        if case .workBlock(_, let emoji) = task.type {
            let start = task.startDelay
            
            for i in 0...9 {
                let delay = start + ((task.duration / 10) * Double(i))
                DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                    
                    let dateString = self.dateFormatter.string(from: Date())
                    let newLine = dateString + ": " + emoji + " - \(i + 1)/10"
                    
                    self.lines.append(newLine)
                    if self.lines.count > self.numberOfVisibleLines {
                        self.lines.removeFirst()
                    }
                }
            }
        }
    }
}

struct CodeConsole_Previews: PreviewProvider {
    static var previews: some View {
        CodeConsole(tasks: [])
    }
}
