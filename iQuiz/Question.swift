//
//  Question.swift
//  iQuiz
//
//  Created by Srinidhi Balaraman on 5/17/22.
//

import Foundation

class Question {
    var question : String!
    var option1 : String!
    var option2 : String!
    var option3 : String!
    var answer : String!
    
    public init(question : String, option1 : String, option2 : String, option3 : String, answer : String) {
        self.question = question
        self.option1 = option1
        self.option2 = option2
        self.option3 = option3
        self.answer = answer
    }
}
