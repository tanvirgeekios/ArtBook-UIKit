//
//  ViewController.swift
//  ArtBook
//
//  Created by MD Tanvir Alam on 16/3/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var artTableView: UITableView!
    var nameArray = [String]()
    var idArray = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        artTableView.delegate = self
        artTableView.dataSource = self
        //getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.nameArray = []
        self.idArray = []
        getData()
    }
    
    func getData(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    self.nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID{
                    self.idArray.append(id)
                }
            }
        } catch  {
            print("Error Fetching Data")
        }
        DispatchQueue.main.async {
            self.artTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = nameArray[indexPath.row]
        return cell
    }
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "detailVCSegue", sender: nil)
    }
}

