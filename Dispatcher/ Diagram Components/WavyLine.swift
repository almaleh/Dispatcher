//
//  WavyLine.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-18.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct WavyLine: Shape {
    
    var threadLength: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        
        let start = CGPoint(x: rect.size.width / 2, y: 0.0)
        
        var path = Path()
        path.move(to: start)
                
        let reps = 6
        let lengthStep = rect.size.height / CGFloat(reps)

        
        for i in 1...reps {
            
            let sign: CGFloat = i % 2 == 0 ? -1 : 1
            
            let verticalOffset = lengthStep * CGFloat(i)
            let previousHeight = lengthStep * CGFloat(i - 1)
            let horizontalOffset = rect.size.width / 5 * sign
            let widthFactor = (start.x + horizontalOffset)
            
            let straightTarget = CGPoint(x: start.x, y: verticalOffset)
            let fraction: CGFloat = 3
            let control1 = CGPoint(x: widthFactor, y: previousHeight + (lengthStep / fraction))
            let control2 = CGPoint(x: widthFactor, y: verticalOffset - (lengthStep / fraction))
            
            
            path.addCurve(to: straightTarget, control1: control1, control2: control2)
            
        }
        
        return path.trimmedPath(from: 0.0, to: threadLength)
    }
    
    var animatableData: CGFloat {
        get { self.threadLength }
        set { self.threadLength = newValue }
    }
}



struct WavyLine_Previews: PreviewProvider {
    static var previews: some View {
        WavyLine()
    }
}
