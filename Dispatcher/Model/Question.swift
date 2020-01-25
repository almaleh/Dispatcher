//
//  Question.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-23.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import Foundation

struct Question: Decodable {
    
    let question: String
    var code: String
    let answers: [String]
    let correctAnswer: Int
    let explanation: String
    
    static func questionsArray() -> [Question] {
        guard let url = Bundle.main.url(forResource: "quiz", withExtension: "json") else { fatalError("Missing bundle data") }
        guard let data = try? Data(contentsOf: url) else { fatalError("Missing bundle data") }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard var questions = try? decoder.decode([Question].self, from: data) else { fatalError("Missing bundle data") }
        
        for i in 0..<questions.count {
            questions[i].code = QuizCode.list[i]
        }
        
        return questions
    }
    
    private static func readQuestionsCode() -> [String] {
        QuizCode.list
    }
    
}
