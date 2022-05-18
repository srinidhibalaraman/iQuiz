//
//  ViewController.swift
//  iQuiz
//
//  Created by Srinidhi Balaraman on 5/16/22.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var subjectList = [Subject]()
    
    var alert : UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initList()        
        alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
    }
    
    func initList() {
        let math = Subject(subject: "Mathematics", description: "Test your number knowledge!", imageName: "math-icon", questions: [Question(question: "What is 6 * 12?", option1: "18", option2: "612", option3: "126", answer: "72"),
            Question(question: "What is 35 % 6?", option1: "6", option2: "30", option3: "4", answer: "5")])
        subjectList.append(math)
        let marvel = Subject(subject: "Marvel Superheroes", description: "Do you know your marvel superheroes?", imageName: "marvel-icon", questions: [Question(question: "Who is the author of the Marvel Comics?", option1: "Tony Stark", option2: "Steve Rogers", option3: "Robert Bruce Banner", answer: "Stan Lee")])
             
        subjectList.append(marvel)
        let science = Subject(subject: "Science", description: "Atoms, Molecules, Mitochondria, and more!", imageName: "science-icon", questions: [Question(question: "What is the powerhouse of the cell?", option1: "Nucleus", option2: "Electron", option3: "AntiBody", answer: "Mitochondria")])
        
        subjectList.append(science)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID") as! TableViewCell
        
        let thisSubject = subjectList[indexPath.row]
        tableViewCell.subjectLabel.text = thisSubject.subject
        tableViewCell.descLabel.text = thisSubject.description
        tableViewCell.iconImage.image = UIImage(named: thisSubject.imageName)
        
        return tableViewCell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let topic = tableView.indexPathForSelectedRow {
            let topicIndex = topic.row
            let questionVC = segue.destination as! QuestionViewController
            questionVC.questions = subjectList[topicIndex].questions
            questionVC.questionIndex = 0
        }
    }
    
    @IBAction func unwindSegue(_ sender: UIStoryboardSegue) {
        print("unwinding")
    }
    
    @IBAction func openSettingsAlert(_ sender: Any) {
        self.present(alert, animated: true)
    }
    

}

