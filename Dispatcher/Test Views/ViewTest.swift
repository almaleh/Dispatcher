//
//  ViewTest.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-19.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct ViewTest: View {
    
    @State var height: CGFloat = 50
    @State var visible = true
    
    var body: some View {
        VStack {
            if visible {
            Text("This is a test")
//                .frame(width: 100, height: height)
                .frame(minHeight: height)
//                .opacity(visible ? 1.0 : 0.0)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeOut(duration: 1)) {
                            self.visible = false
//                            self.height = 0.0
                        }
                    }
            }
            }
            Text("El Segundo")
            Spacer()
        }
    }
}

struct ViewTest_Previews: PreviewProvider {
    static var previews: some View {
        ViewTest()
    }
}
