//
//  Quiz.swift
//  iQuiz
//
//  Created by Srinidhi Balaraman on 5/19/22.
//

import UIKit

class Quiz {
    var title : String
    var desc : String
    var questions : [Question]
    
    init(title: String, desc: String, questions: [Question]) {
        self.title = title
        self.desc = desc
//        self.img = #imageLiteral(resourceName: "math")
        self.questions = questions
    }
    
}
