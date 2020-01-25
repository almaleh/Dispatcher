//
//  QuizProcessor.swift
//  Dispatcher
//
//  Created by Besher on 2020-01-24.
//  Copyright © 2020 Besher Al Maleh. All rights reserved.
//

import Foundation

struct QuizProcessor {
    let questionsArray: [Question]
    var question: Question {
        guard questionNumber - 1 < questionsArray.count else {
            return questionsArray[questionsArray.count - 1]
        }
        return questionsArray[questionNumber - 1]
    }
    var questionNumber: Int
    var score = [Int: Bool]()
    var quizOver = false
    
    var totalScore: Int {
        score.reduce(0) {
            let scoreAdjustment = $1.value == true ? 1 : 0
            return $0 + scoreAdjustment
        }
    }
    
    mutating func answered(with answer: Int) {
        let correct = answer == question.correctAnswer
        score[questionNumber] = correct
        if questionNumber >= questionsArray.count { quizOver = true }
        questionNumber += 1
    }
    
    mutating func explain(question: Int) {
        questionNumber = question
    }
}
