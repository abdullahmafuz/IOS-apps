//
//  ViewController.swift
//  alarmofire
//
//  Created by Abdullah Mohammed on 25/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var movieList = [String]()
    var movieClass : StarWarApi?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }


    // get data
    
    func getData (){
        
        Alamofire.request("https://swapi.co/api/films/").responseString { (response) in
            
            if let res = response.value {
                if let object = Mapper<StarWarApi>().map(JSONString: res) {
               
                   
                    if let list = object.starWar?[0] {
                        print(list.title ?? "Rizwan")
                    }
                    self.movieClass = object
                    
                    for item in object.starWar! {
                        self.movieList.append(item.title!)
                        
                        self.tableView.reloadData()
                    }
                    
                }
                
            }
        }
       
        
    }
    
    
    // table
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
       
        
        cell.textLabel?.text = movieClass?.starWar![indexPath.row].title
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return movieList.count
    }
    
    
    
    
    
}

