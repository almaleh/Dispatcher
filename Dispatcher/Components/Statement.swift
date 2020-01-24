//
//  Statement.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

enum DispatchType: String {
    case sync, async, shadow = "Sync", done = "Main Queue Done"
    
    var title: String {
        return rawValue.capitalized
    }
    
    var color: Color {
        switch self {
        case .sync: return .red
        case .async: return .blue
        case .done: return .purple
        case .shadow: return .clear
        }
    }
}

struct Statement: View {
    
    let type: DispatchType
    
    @State private var ringScale: CGFloat = 1.0
    @State private var currentOpacity = 1.0
    @State private var isPulsing = true
    
    private let task: Task
    private var statementDuration: Double { task.duration }
    private var startTime: Date { task.startTime }
    
    var body: some View {
        Group {
            if currentOpacity > 0 {
                if isPulsing == false {
                    baseStatement
                } else {
                    baseStatement
                        .overlay(
                            Capsule()
                                .stroke(type.color)
                                .scaleEffect(ringScale)
                                .opacity(Double(2 - ringScale))
                                .animation(
                                    type == .sync ?
                                        Animation.easeOut(duration: 1.0)
                                            .repeatCount(Int(statementDuration), autoreverses: false)
                                        : nil)
                    )
                }
            }
        }
        .padding([.top, .bottom], 20)
        .onAppear(perform: {
            self.startPulsing()
            var startDelay: Double = self.task.startDelay
            let extraDuration = self.type == .sync || self.type == .shadow ?
                self.statementDuration * 0.9 : 0.0
            
            startDelay = Double(Int(startDelay))
            DispatchQueue.main.asyncAfter(deadline: .now() + extraDuration + startDelay) {
                self.disappear()
            }
        })
    }
    
    var baseStatement: some View {
        Text(type.title)
            .foregroundColor(type == .shadow ? .clear : .white)
            .padding(8)
            .frame(maxWidth: 150)
            .background(type.color)
            .clipShape(Capsule())
            .opacity(currentOpacity)
            .multilineTextAlignment(.center)
            .animation(.default)
    }
    
    init(type: DispatchType, task: Task) {
        self.type = type
        self.task = task
    }
    
    func startPulsing() {
        guard type == .sync else { return }
        self.ringScale = 2.0
        self.isPulsing = true
    }
    
    func disappear() {
        withAnimation(.easeOut(duration: 0.70)) {
            self.isPulsing = false
            self.currentOpacity = 0.0
        }
    }
}

struct Statement_Previews: PreviewProvider {
    static var previews: some View {
        Statement(type: .done, task: Task(.statement(.done), Date(), Date(), 0.5))
    }
}
