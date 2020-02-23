//
//  detailsViewController.swift
//  tableView
//
//  Created by Abdullah Mohammed on 23/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var detaillabel: UILabel!
    
    var img = UIImage()
    var details = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgView.image = img
        detaillabel.text = details
    }
 
    

}
