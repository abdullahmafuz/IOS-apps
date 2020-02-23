//
//  ViewController.swift
//  birthdday-notes
//
//  Created by Abdullah Mohammed on 22/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // items
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var birth: UITextField!
    
    @IBOutlet weak var btnEnter: UIButton!
    
    @IBOutlet weak var btnDel: UIButton!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var birthLabel: UILabel!
    
    
    var userName = ""
    var birthDay = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        
       let  storedUserName = UserDefaults.standard.object(forKey: "userName")
    
        let storedBirthDay = UserDefaults.standard.object(forKey: "birthDay")
        
        if storedUserName != nil  {
            nameLabel.text = "Name :\(storedUserName ?? "")"
        }
        
        if storedBirthDay != nil {
            birthLabel.text = "Birthday :\(storedBirthDay ?? "")"
        }
        
    }

   
    @IBAction func enterEvent(_ sender: Any) {
        
        userName = name.text!
        birthDay = birth.text!
        
        nameLabel.text! = "Name :\(userName)"
        birthLabel.text! = "Birthday :\(birthDay)"
        
        UserDefaults.standard.set(userName, forKey:"userName")
        UserDefaults.standard.set(birthDay, forKey:"birthDay")
        
        if (userName != ""){
        performSegue(withIdentifier: "toSecondVC", sender:nil)
        }
        else{
            
            let alert = UIAlertController(title: "Error!", message: "Name is require", preferredStyle: UIAlertController.Style.alert)
            let btnOk = UIAlertAction(title: "Got it", style: UIAlertAction.Style.default) { (UIAlertAction) in
        
            }
            alert.addAction(btnOk)
            self.present(alert, animated:true, completion: nil)
            
            
            
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toSecondVC"{
           let destinationVC = segue.destination as! secondViewController
            
            destinationVC.userName = userName
            destinationVC.birthDay = birthDay
        }
        
    }
    
    
    @IBAction func deleteEvent(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "userName")
        UserDefaults.standard.removeObject(forKey: "birthDay")
         nameLabel.text! = "Name :"
         birthLabel.text! = "Birthday :"
    }
}

