//
//  ViewTest.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct ViewTest: View {
    
    @State var size: CGFloat = 1
    
    var body: some View {
        Text("This is a test")
        .scaleEffect(size)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 1).delay(5)) {
                    self.size += 1
                    print("Animation is done!")
                }
        }
    }
}

struct ViewTest_Previews: PreviewProvider {
    static var previews: some View {
        ViewTest()
    }
}
