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
    var selectedName = ""
    var selectedId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(onBtnClick))
        
        table.delegate = self
        table.dataSource = self
        
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "updatedData"), object: nil)

       
    
    }


    @objc func onBtnClick (){
        selectedName = ""
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    @objc func getData (){
        
        nameArr.removeAll(keepingCapacity: false)
        idArr.removeAll(keepingCapacity: false)
        
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
        
        table.reloadData()
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let tbCell = UITableViewCell()
        
        tbCell.textLabel?.text = nameArr[indexPath.row]
        

        
        return tbCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return nameArr.count
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetailVC" {
            
            let destinationVC = segue.destination as! detailVC
                destinationVC.choosenname = selectedName
            destinationVC.choosenId = selectedId
            
            
            
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedName = nameArr[indexPath.row]
        selectedId = idArr[indexPath.row]
        
        performSegue(withIdentifier: "toDetailVC", sender: nil)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
        
        
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Gallery")
            
            let deletedItem = idArr[indexPath.row].uuidString
            
            fetchReq.predicate = NSPredicate(format: "id = %@", deletedItem)
            
            fetchReq.returnsObjectsAsFaults = false
            
            
            do{
                
                let results = try context.fetch(fetchReq)
                
                if results.count > 0 {
                    for res in results as! [NSManagedObject]{
                        if let id = res.value(forKey: "id") as? UUID{
                            
                            if id == idArr[indexPath.row]{
                                context.delete(res)
                                nameArr.remove(at: indexPath.row)
                                idArr.remove(at: indexPath.row)
                                
                                self.table.reloadData()
                                do {
                                    try context.save()
                                } catch  {
                                   
                                    print("error")
                                }
                                break
                            }
                            
                        }
                    }
                }
                
            }catch{
                
            }
            
        }
        
    }
    
}

