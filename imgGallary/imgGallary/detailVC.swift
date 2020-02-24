//
//  detailVC.swift
//  imgGallary
//
//  Created by Abdullah Mohammed on 24/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit
import CoreData

class detailVC: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var caption: UITextField!
    @IBOutlet weak var savebtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(gestureRecognizer)
        
        image.isUserInteractionEnabled = true
        
        let pickerGesture = UITapGestureRecognizer(target: self, action: #selector(imagePicker))
        
        image.addGestureRecognizer(pickerGesture)
        
    }
    
    @objc func imagePicker (){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveEvent(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let Context = appDelegate.persistentContainer.viewContext
        
        let newGallery = NSEntityDescription.insertNewObject(forEntityName: "Gallery", into: Context)
        
        // Atributes
        
        newGallery.setValue(name.text, forKey: "name")
        newGallery.setValue(caption.text, forKey: "caption")
        newGallery.setValue(UUID(), forKey: "id")
        
        let imgData = image.image!.jpegData(compressionQuality: 0.5)
        
        newGallery.setValue(imgData, forKey: "image")
        
        
        do{
            try Context.save()
            print("Success!!")
        } catch{
        print("error")
        }
        
    }
    
    
    @objc func hideKeyBoard (){
        
        view.endEditing(true)
    }
    
}
