//
//  ViewController.swift
//  tableView
//
//  Created by Abdullah Mohammed on 23/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var sports = [String]()
    var sportsImg = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sports.append("baseball")
        sports.append("basketball")
        sports.append("crickets")
        sports.append("football")
        sports.append("golf")
   
        sportsImg.append(UIImage(named:"baseball")!)
        sportsImg.append(UIImage(named:"basketball")!)
        sportsImg.append(UIImage(named:"cricket")!)
        sportsImg.append(UIImage(named:"football")!)
        sportsImg.append(UIImage(named:"golf")!)
        
        navigationItem.title = "Sports Details"
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            sports.remove(at: indexPath.row)
            sportsImg.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.fade)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        cell.textLabel?.text = sports[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    var toSendImg = UIImage()
    var toSendDetails = ""
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
        
        toSendImg = sportsImg[indexPath.row]
        toSendDetails = sports[indexPath.row]
       
          performSegue(withIdentifier: "toDetailsView", sender: nil)
    
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "toDetailsView" {
           let DetailsView = segue.destination as! detailsViewController
            
            DetailsView.details = toSendDetails
            DetailsView.img = toSendImg
  
    }


    }




}



