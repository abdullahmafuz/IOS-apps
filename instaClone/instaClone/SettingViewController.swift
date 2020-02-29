//
//  SettingViewController.swift
//  instaClone
//
//  Created by Abdullah Mohammed on 27/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutEvent(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toMainVC", sender: nil)
        }catch{
            print("Error")
        }
        
        
    }
    

}
