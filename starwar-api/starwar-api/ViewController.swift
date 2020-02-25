//
//  ViewController.swift
//  starwar-api
//
//  Created by Abdullah Mohammed on 25/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    
      var arrOfTitle = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableview.delegate = self
        tableview.dataSource = self
        
          navigationItem.title = "Star War Movies"
        
        starWarApi()

       
    }

    

  

    func starWarApi (){
        
        let url = URL(string: "https://swapi.co/api/films/")
  
        
        let session = URLSession.shared
        
        // Closure
        
        let task = session.dataTask(with: url!) { (data, res, error) in
            
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
             
            }else{
                
                if data != nil{
                    
                    do{
                        
                        let jsonRes = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String , Any>
                        
                        
                        // Async
                        
                        DispatchQueue.main.async {
                            
                            
                            if let results = jsonRes["results"] as? Array<Any>{
                                
                                for item in results {
                                    let res = item as? Dictionary<String, Any>
                                 
                                    if let title = res?["title"] as? String {
                                        self.arrOfTitle.append(title)
                                }
                                
                                
                                }
                                
                                self.tableview.reloadData()
                                
                            }
                               
                            
                             
                       }
                        
                        
                    }catch{
                        print("errorrr")
                    }
                    
                }
                
            }
           
            
        }
        
        
        
        task.resume()
        
        
        
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return arrOfTitle.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        print(arrOfTitle[indexPath.row])

        cell.textLabel?.text = arrOfTitle[indexPath.row]
               return cell
    }
    


}


