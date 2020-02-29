//
//  SignUpViewController.swift
//  instaClone
//
//  Created by Abdullah Mohammed on 27/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    

    @IBAction func onSignUp(_ sender: Any) {
        
        if password.text == confirmPassword.text && emailText.text != ""{
            Auth.auth().createUser(withEmail: emailText.text ?? "", password: password.text ?? ""
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
    
    func alertEvent(alertTitle:String,alertMessage:String){
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
