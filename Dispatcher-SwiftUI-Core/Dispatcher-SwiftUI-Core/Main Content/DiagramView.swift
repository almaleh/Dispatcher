//
//  DiagramView.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-16.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

enum Topic: String, CaseIterable {
    case sync, async, serial, concurrent
    
    var numberOfQueues: Int {
        switch self {
        case .sync: return 2
        case .async: return 2
        case .serial: return 2
        case .concurrent: return 2
        }
    }
    
    var explanation: String {
        switch self {
        case .sync: return Explanations.sync
        case .async: return Explanations.async
        case .serial: return Explanations.serial
        case .concurrent: return Explanations.concurrent
        }
    }
}

struct DiagramView: View {
    
    @State private var topic = 0
    @Binding var didStart: Bool
    
    let spacing: CGFloat = 20
    
    var body: some View {
        VStack (spacing: spacing) {
            VStack {
                Text("Explain")
                Picker("Topic", selection: $topic) {
                    ForEach(0..<Topic.allCases.count, id: \.self) { num in
                        Text(Topic.allCases[num].rawValue.capitalized)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Scheduler(topic: topic, didStart: $didStart)
        }
        .padding([.leading, .trailing, .bottom], spacing)
            // Dirty 'hack' to restart animation on tab change, not proud of it
            .opacity(didStart ? 1.0 : 0.99)
            .onAppear {
                self.didStart = !self.didStart
        }
    }
}

struct DiagramView_Previews: PreviewProvider {
    static var previews: some View {
        DiagramView(didStart: .constant(true))
    }
}
