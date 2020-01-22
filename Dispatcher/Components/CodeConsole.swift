//
//  CodeConsole.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-20.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import SwiftUI

struct CodeConsole: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    var lines = [
        "jan 13, 2020: First",
        "jan 13, 2020: First",
        "jan 13, 2020: First",
        "jan 13, 2020: First",
        "jan 13, 2020: First",
        "jan 13, 2020: First",
        "jan 13, 2020: First",
    ]
    
    var body: some View {
        ScrollView {
            ForEach (0..<lines.count, id: \.self) { index in
                Text(self.lines[index])
                    .foregroundColor(.white)
                    .font(.system(size: 14, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(5)
        .background(
            Color.black.brightness(0.2)
                .border(Color.black, width: 2)
        )
        .cornerRadius(3)
        .padding([.trailing, .leading], 25)
    }
}

struct CodeConsole_Previews: PreviewProvider {
    static var previews: some View {
        CodeConsole()
    }
}
