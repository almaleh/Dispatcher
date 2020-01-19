//
//  DiagramView.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-16.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

enum Topic: String, CaseIterable {
    case serial, concurrent, sync, async
    
    var numberOfQueues: Int {
        switch self {
        case .sync: return 2
        case .async: return 2
        case .serial: return 2
        case .concurrent: return 2
        }
    }
}

struct DiagramView: View {
    
    @State private var topic = 0
    @State private var didStart = false
    var startButtonText: String {
        didStart ? "Stop" : "Start"
    }
    
    var startButtonImage: String {
        didStart ? "stop.circle.fill" : "play.circle.fill"
    }
    
    let spacing: CGFloat = 25
    
    var body: some View {
        VStack (spacing: spacing) {
            VStack {
                Text("Explain")
                    .font(.title)
                Picker("Topic", selection: $topic) {
                    ForEach(0..<Topic.allCases.count, id: \.self) { num in
                        Text(Topic.allCases[num].rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Scheduler(topic: topic, didStart: $didStart)
            Button(action: {
                self.didStart = !self.didStart
            }) {
                HStack {
                    Text(self.startButtonText)
                    Image(systemName: self.startButtonImage)
                }
                .font(.title)
            }
        }
        .padding(spacing)
    }
}

struct DiagramView_Previews: PreviewProvider {
    static var previews: some View {
        DiagramView()
    }
}
