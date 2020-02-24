//
//  ViewController.swift
//  houseBook(OOP)
//
//  Created by Abdullah Mohammed on 23/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableListView: UITableView!
    @IBOutlet var listView: UIView!
    var arrOfMansion = [Mansion]()
    
    var choosenMansion : Mansion?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableListView.delegate = self
        tableListView.dataSource = self
        
        navigationItem.title = "Mansion deatils"
        // creating masnion Object
        
        let man1 = Mansion(mansionName: "Mansion-1", mansionPrice: "12M", mansionImg: UIImage(named: "mansion1")!)
        let man2 = Mansion(mansionName: "Mansion-2", mansionPrice: "22", mansionImg: UIImage(named: "mansion2")!)
        let man3 = Mansion(mansionName: "Mansion-3", mansionPrice: "32M", mansionImg: UIImage(named: "mansion3")!)
        let man4 = Mansion(mansionName: "Mansion-4", mansionPrice: "44M", mansionImg: UIImage(named: "mansion4")!)
        
        arrOfMansion = [man1,man2,man3,man4]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = arrOfMansion[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfMansion.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        choosenMansion = arrOfMansion[indexPath.row]
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailsVC"{
            
            let destinationVC = segue.destination as? detailViewController
            
            destinationVC?.selectedmansion = choosenMansion
            
        }
        
        
    }
  


}

