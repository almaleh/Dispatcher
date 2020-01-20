//
//  WorkBlock.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct WorkBlock: View {
    
    
    @State private var progress: CGFloat = 1.0
    @State private var borderOpacity: Double = 1.0
    @State private var scale: CGFloat = 0.5
    
    private let startTime: Date
    private let taskDuration: Double
    private let color: Color
    private let possibleBlockColors: [Color] = [.purple]
    
    
    var body: some View {
        return color
            .frame(width: 60, height: 150 * progress)
            .border(Color.yellow.opacity(borderOpacity), width: 3)
            .scaleEffect(scale)
            .onAppear {
                self.startTask()
                withAnimation(.easeOut(duration: 0.3)) {
                    self.scale = 1.0
                }
        }
    }
    
    init (startTime: Date, taskDuration: Double, color: Color) {
        self.color = color
        self.startTime = startTime
        self.taskDuration = taskDuration
    }
    
    func startTask() {
        let startDelay =  max(startTime.timeIntervalSince(Date()), 0.0)
        
//        isCollapsing ? 1.5 : 2.0 + taskDuration
        
        withAnimation(Animation
            .linear(duration: 5.0)
            .delay(startDelay)) {
            self.progress = 0.0
        }
        withAnimation(Animation
            .linear(duration: self.taskDuration / 4)
            .delay(startDelay + (3 * self.taskDuration / 4))) {
            self.borderOpacity = 0.0
        }
    }
}

struct WorkBlock_Previews: PreviewProvider {
    static var previews: some View {
        WorkBlock(startTime: Date(), taskDuration: 5.0, color: .red)
    }
}
