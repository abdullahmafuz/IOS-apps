//
//  secondViewController.swift
//  birthdday-notes
//
//  Created by Abdullah Mohammed on 22/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var birth: UILabel!
    var userName : String?
    var birthDay : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = userName
        birth.text = birthDay
        
        
    }
    

  

}
