//
//  ViewTest.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct ViewTest: View {
    
    @State var visible = true
    
    var body: some View {
        return Group {
                Text("We are here, after all")
                    .background(Color.red.opacity(visible ? 1.0 : 0.0))
//                    .animation(.easeOut(duration: 0.5))
                    .animation(nil)
                    .scaleEffect(visible ? 1 : 0)
                    .animation(.easeOut(duration: 5.0))
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.visible = false
            }
        }
    }
}

struct ViewTest_Previews: PreviewProvider {
    static var previews: some View {
        ViewTest()
    }
}
