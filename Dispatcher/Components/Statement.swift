//
//  Statement.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

enum DispatchType: String {
    case sync, async
    
    var title: String {
        return rawValue.capitalized
    }
    
    var color: Color {
        switch self {
        case .sync: return .red
        case .async: return .blue
        }
    }
}

struct Statement: View {
    
    let type: DispatchType
    
    @State private var ringScale: CGFloat = 1.0
    @State private var currentOpacity = 1.0
    @State private var isPulsing = true
    
    var body: some View {
        Group {
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
                                    Animation.easeOut(duration: 0.8)
                                        .repeatCount(5, autoreverses: false)
                                    : nil)
                )
            }
        }
        .onAppear(perform: {
            self.startPulsing()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.disappear()
            }
        })
    }
    
    var baseStatement: some View {
        Text(type.title)
            .foregroundColor(.white)
            .padding(8)
            .background(type.color)
            .clipShape(Capsule())
            .opacity(currentOpacity)
            .animation(.default)
    }
    
    func startPulsing() {
        self.ringScale = 2.0
        self.isPulsing = true
    }
    
    func disappear() {
        self.isPulsing = false
        self.currentOpacity = 0.0
    }
}

struct Statement_Previews: PreviewProvider {
    static var previews: some View {
        Statement(type: .async)
    }
}
