//
//  QuizCode.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-24.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import Foundation

struct QuizCode {
    
    static let list: [String] = [q1, q2, q3]
    
    private static let q1 = """

    DispatchQueue.main.async {
        // Loop A
        for i in 0...10 {
            print(i)
        }
    }
    DispatchQueue.global().async {
        // Loop B
        for i in 50...60 {
            print(i)
        }
    }

    """
    private static let q2 = """

    DispatchQueue.global().sync {
        // Loop A
        for i in 0...10 {
            print(i)
        }
    }
    DispatchQueue.global().async {
        // Loop B
        for i in 50...60 {
            print(i)
        }
    }

    """
    
    private static let q3 = """

    DispatchQueue.global().async {
        // Loop A
        for i in 0...10 {
            print(i)
        }
    }
    DispatchQueue.global().async {
        // Loop B
        for i in 50...60 {
            print(i)
        }
    }

    """
    
    
}
