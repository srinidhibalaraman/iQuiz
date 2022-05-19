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
    
    var urlString: String = "https://tednewardsandbox.site44.com/questions.json"

    var refreshControl = UIRefreshControl()
    
    var images = ["science-icon", "marvel-icon",  "math-icon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initList()
        fetchJsonData()
        
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(sender: Any?) {
        fetchJsonData()
        self.refreshControl.endRefreshing()
    }
    
    func internetAvailable() -> Bool {
        if NetworkMonitor.shared.isConnected {
            print("you're connected")
            return true
        } else {
            print("you're not connected")
            return false
        }
    }
    
    func fetchJsonData(){
        let url = URLRequest(url: URL(string: urlString)!)
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let fileName = "data.json"
        
        if internetAvailable() {
            let session = URLSession.shared.dataTask(with: url) { (data, res, err) in

                guard let data = data else {
                    return
                }
                            
                guard let httpResponse = res as? HTTPURLResponse, httpResponse.statusCode == 200
                else {
                    let alert = UIAlertController(title: "Error", message: "error with http response", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                
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
        } else {
            let alert = UIAlertController(title: "Error", message: "error parsing data", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
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
        tableViewCell.iconImage.image = UIImage(named: images[indexPath.row])
        
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
        
        let alert = UIAlertController(title: "Settings", message: "Enter Question URL", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "URL"
            if let url = UserDefaults.standard.string(forKey: "question_url") {
                textField.text = url
            }
        }
        alert.addAction(UIAlertAction(title: "Check Now", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            if textField?.text == "" {
                return
            }
            guard (URL(string: (textField?.text)!) != nil) else {
                let alert = UIAlertController(title: "Error", message: "Invalid URL", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            UserDefaults.standard.set(textField?.text, forKey: "question_url")
            self.fetchJsonData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

}
