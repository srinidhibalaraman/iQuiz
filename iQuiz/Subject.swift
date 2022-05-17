//
//  Subject.swift
//  iQuiz
//
//  Created by Srinidhi Balaraman on 5/17/22.
//

import Foundation

class Subject {
    var subject : String!
    var description : String!
    var imageName : String!
    
    public init(subject:String, description:String, imageName:String) {
        self.subject = subject
        self.description = description
        self.imageName = imageName
    }
}
