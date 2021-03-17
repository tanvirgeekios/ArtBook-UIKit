//
//  ViewController.swift
//  ArtBook
//
//  Created by MD Tanvir Alam on 16/3/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var artTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
    }
    
    @objc func addButtonClicked(){
        performSegue(withIdentifier: "detailVCSegue", sender: nil)
    }
}

