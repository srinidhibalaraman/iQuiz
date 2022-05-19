//
//  ViewController.swift
//  iQuiz
//
//  Created by Srinidhi Balaraman on 5/16/22.
//

import UIKit

struct Topic : Decodable {
    var title : String
    var desc : String
    var questions : [QuestionStruct]
}

struct QuestionStruct : Decodable {
    var text : String
    var answer : String
    var answers : [String]
}

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var subjectList = [Quiz]()
    
    var alert : UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initList()
        fetchJsonData()
        
    }
    
    func fetchJsonData(){
        let url = URL(string: "https://tednewardsandbox.site44.com/questions.json")
        let session = URLSession.shared.dataTask(with: url!) { (data, res, err) in

            guard let data = data else {
                return
            }
                        
            print(data)
            
            guard let categories = try? JSONDecoder().decode([Topic].self, from: data) else {
                // Couldn't decode data into a Topic
                return
            }
            
            var fetchedQuizzes : [Quiz] = []
            
            for c in categories {
                var questionList : [Question] = []
                for q in c.questions {
                    questionList.append(Question(text: q.text, answer: q.answer, answers: q.answers))
                }
                fetchedQuizzes.append(Quiz(title: c.title, desc: c.desc, questions: questionList))
            }
            
            print(fetchedQuizzes.count)
            
            DispatchQueue.main.async{
                self.subjectList = fetchedQuizzes
//                self.dataSource = QuizDataSource(self.quiz)
//                self.TopicTableView.dataSource = self.dataSource
                self.tableView.reloadData()
            }
        }
        session.resume()
    }
        
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(subjectList.count)
        return subjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellID") as! TableViewCell
        
        let thisSubject = subjectList[indexPath.row]
        tableViewCell.subjectLabel.text = thisSubject.title
        tableViewCell.descLabel.text = thisSubject.desc
//        tableViewCell.iconImage.image = UIImage(named: thisSubject.imageName)
        
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
        
        alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    

}

