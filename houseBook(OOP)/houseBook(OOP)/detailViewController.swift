//
//  detailViewController.swift
//  houseBook(OOP)
//
//  Created by Abdullah Mohammed on 23/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    
    var selectedmansion : Mansion?

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = selectedmansion?.name
        titleLabel.text = "Price : \(selectedmansion?.price ?? "")"
        imgView.image = selectedmansion?.img
        
    }
    

  

}
