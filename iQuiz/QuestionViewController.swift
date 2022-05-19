//
//  QuestionViewController.swift
//  iQuiz
//
//  Created by Srinidhi Balaraman on 5/17/22.
//

import Foundation
import UIKit


class AnswerCell: UITableViewCell {
    @IBOutlet weak var answerLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.backgroundColor = UIColor.systemCyan
            answerLabel.textColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.lightGray
            answerLabel.textColor = UIColor.white
        }
    }
}

class QuestionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var questionTableView: UITableView!
    @IBOutlet weak var answerButton: UIButton!
    
    var questions : [Question] = []
    var questionIndex : Int = 0
    var options : [String] = []
    var selected : Int = -1
    var correctAnswers : Int = 0
    var totalAnswers : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTableView.delegate = self
        questionTableView.dataSource = self
        print(questionIndex)
        questionLabel.text = questions[questionIndex].text
        options = [questions[questionIndex].answers[0], questions[questionIndex].answers[1], questions[questionIndex].answers[2], questions[questionIndex].answers[3]]
        progressLabel.text = "\(correctAnswers + 1) out of \(questions.count)"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = (tableView.indexPathForSelectedRow?.row)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "answerCell") as! AnswerCell
        
        tableViewCell.answerLabel.text = options[indexPath.row]
        
        return tableViewCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let feedbackVC = segue.destination as! FeedbackViewController
        feedbackVC.questions = questions
        feedbackVC.questionIndex = questionIndex
        feedbackVC.questionTitle = questionLabel.text!
        feedbackVC.selected = options[selected]
        feedbackVC.correctAnswers = correctAnswers
        feedbackVC.totalAnswers = totalAnswers
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        if selected == -1 {
            let alert = UIAlertController(title: "Error", message: "Select an Answer", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "answerPage", sender: self)
        }
    }
}
