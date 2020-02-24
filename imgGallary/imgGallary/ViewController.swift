//
//  ViewController.swift
//  imgGallary
//
//  Created by Abdullah Mohammed on 24/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    var nameArr = [String]()
    var idArr = [UUID]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(onBtnClick))
        
        table.delegate = self
        table.dataSource = self
        
        getData()
    }


    @objc func onBtnClick (){
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    func getData (){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Gallery")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject] {
                if let name = result.value(forKey: "name") as? String{
                    nameArr.append(name)
                    
                }
                if let id = result.value(forKey: "id") as? UUID {
                    idArr.append(id)
                }
            }
        }catch{
            print("errrorrr")
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let tbCell = UITableViewCell()
        
        tbCell.textLabel?.text = nameArr[indexPath.row]
        
        return tbCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return nameArr.count
        
    }
    
}

