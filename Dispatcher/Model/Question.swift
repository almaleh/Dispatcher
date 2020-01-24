//
//  Question.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-23.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import Foundation

struct Question {
    let question: String
    let code: String
    let answers: [String]
    let correctAnswer: Int
}

let sampleQ = "What is the outcome of this code?"
let sampleC = """
                                                    
DispatchQueue.main.async {
    for i in 1...10 {
        print(i)
    }
}

DispatchQueue.global().async {
    for i in 51...60 {
        print(i)
    }
}
"""
let sampleA = ["First then second", "Both finish simultaneously", "Second then first", "WAPO"]
let correctA = 1

let sampleQuestion = Question(question: sampleQ, code: sampleC, answers: sampleA, correctAnswer: correctA)

let sampleQuestionsArray = [Question](repeatElement(sampleQuestion, count: 10))

