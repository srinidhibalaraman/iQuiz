
import UIKit

class TableDataAndDelegate : NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var vc : ViewController?
    
    let data : [String] = [
        "Mathematics", "Marvel Superheroes", "Science"
    ]
    
    let desc : [String] = ["check your number knowledge!", "how well do you know your superheroes?", "Atoms, molecules, mitochondria, and more"]
    
    let devCousesImages = [UIImage(named: "math-ison"), UIImage(named: "marvel-icon"), UIImage(named: "science-icon")]

    /*
     UITableViewDataSource methods
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("indexPath.item = \(indexPath.item)", "indexPath.row = \(indexPath.row)")
        
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "dwarf", for: indexPath)
        cell.textLabel!.text = data[indexPath.row] + ": " + desc[indexPath.row]
        cell.imageView?.image = UIImage(named: "\(String(describing: devCousesImages[indexPath.row]))")
        return cell
    }
    
}

class ViewController: UIViewController {
    
    var tableDataAndDelegate = TableDataAndDelegate()
    
    @IBAction func openSettings(_ sender: Any) {
        let alert = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableDataAndDelegate.vc = self
        
        tableView.dataSource = tableDataAndDelegate
        tableView.delegate = tableDataAndDelegate
    }

}

