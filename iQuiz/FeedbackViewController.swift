//
//  FeedbackViewController.swift
//  iQuiz
//
//  Created by Srinidhi Balaraman on 5/17/22.
//

import UIKit

class FeedbackViewController : UIViewController {
    var questions : [Question] = []
    var questionIndex : Int = -1
    var questionTitle : String = ""
    var selected : String = ""
    var correctAnswers : Int = 0
    var totalAnswers : Int = 0
    var end : Bool = false
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        questionLabel.text = questionTitle
        answerLabel.text = questions[questionIndex].answer
        
        print(questions[0].answer)
        if selected == questions[questionIndex].answer {
            feedbackLabel.text = "Correct!"
            correctAnswers += 1
        } else {
            feedbackLabel.text = "Incorrect!"
        }
        
        if questionIndex == questions.count - 1{
            end = true
        }
        
        questionIndex += 1
        totalAnswers += 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "finishPage" {
            let finishedVC = segue.destination as! FinishedViewController
            finishedVC.correctAnswers = self.correctAnswers
            finishedVC.totalAnswers = self.totalAnswers
        } else if segue.identifier == "questionPage" {
            let questionVC = segue.destination as! QuestionViewController
            questionVC.questions = self.questions
            questionVC.questionIndex = self.questionIndex
            questionVC.correctAnswers = self.correctAnswers
            questionVC.totalAnswers = self.totalAnswers
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if end {
            performSegue(withIdentifier: "finishPage", sender: self)
        } else {
            performSegue(withIdentifier: "questionPage", sender: self)
        }
    }
}
