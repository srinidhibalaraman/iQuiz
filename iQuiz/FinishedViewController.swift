//
//  FinishedViewController.swift
//  iQuiz
//
//  Created by Srinidhi Balaraman on 5/17/22.
//

import UIKit

class FinishedViewController : UIViewController {
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var correctAnswers : Int = -1
    var totalAnswers : Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if correctAnswers == totalAnswers {
            feedbackLabel.text = "Perfect!"
        } else {
            feedbackLabel.text = "Try again next time!"
        }
        
        scoreLabel.text = "\(correctAnswers) out of \(totalAnswers)"
    }
}
