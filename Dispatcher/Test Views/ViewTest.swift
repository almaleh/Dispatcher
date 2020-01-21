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
            if visible {
                Text("We are here, after all")
            }
        }
    }
}

struct ViewTest_Previews: PreviewProvider {
    static var previews: some View {
        ViewTest()
    }
}
