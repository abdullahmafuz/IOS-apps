//
//  ViewController.swift
//  instaClone
//
//  Created by Abdullah Mohammed on 27/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

   
    @IBAction func signIn(_ sender: Any) {
        if passwordText.text != "" && emailText.text != ""{
                  Auth.auth().signIn(withEmail: emailText.text ?? "", password: passwordText.text ?? ""
                  ) { (authData, error) in
                      
                      if(error != nil){
                          self.alertEvent(alertTitle: "error", alertMessage: error?.localizedDescription ?? "")
                      }else{
                          self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                      }
                  }
                  
              }else{
                  alertEvent(alertTitle: "Authentication-error", alertMessage: "Please cheek user Username / passwords")
              }
              

    }
    
    
    @IBAction func signOut(_ sender: Any) {
        performSegue(withIdentifier: "toSignUp", sender: nil)
    }
    
    
    func alertEvent(alertTitle:String,alertMessage:String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}

