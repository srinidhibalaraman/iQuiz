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
        // Do any additional setup after loading the view.
        
        alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
    }
    
    func initList() {
        let math = Subject(subject: "Mathematics", description: "Test your number knowledge!", imageName: "math-icon")
        subjectList.append(math)
        let marvel = Subject(subject: "Marvel Superheroes", description: "Do you know your marvel superheroes?", imageName: "marvel-icon")
        subjectList.append(marvel)
        let science = Subject(subject: "Science", description: "Atoms, Molecules, Mitochondria, and more!", imageName: "science-icon")
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
    
    
    @IBAction func openSettingsAlert(_ sender: Any) {
        self.present(alert, animated: true)
    }
    

}

