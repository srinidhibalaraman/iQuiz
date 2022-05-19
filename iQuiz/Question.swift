//
//  Question.swift
//  iQuiz
//
//  Created by Srinidhi Balaraman on 5/17/22.
//

import Foundation

class Question {
    var text : String
    var answer : String
    var answers : [String]
    
    public init(text : String, answer : String, answers : [String]) {
        self.text = text
        self.answer = answer
        self.answers = answers
    }
}
