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
    
    
    var choosenname = ""
    var choosenId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savebtn.isEnabled = false
        
        if choosenname != ""{
            //data core
            savebtn.isHidden = true
            let strUUID = choosenId!.uuidString
           
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Gallery")
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", strUUID)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject]{
                        
                        if let imgname = result.value(forKey: "name") as? String {
                            name.text = imgname
                        }
                        
                        if let imgcaption = result.value(forKey: "caption") as? String {
                            caption.text = imgcaption
                        }
                        
                        if let imgData = result.value(forKey: "image") as? Data {
                            image.image = UIImage(data: imgData)
                        }
                        
                    }
                }
                
            }catch{
                print("errroe")
            }
            
           
           
        }else{
            
            savebtn.isEnabled = false
            name.text = ""
            caption.text = ""
            
        }
        
        
        
        
        
        
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
        savebtn.isEnabled = true
    }
    
    @IBAction func saveEvent(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let Context = appDelegate.persistentContainer.viewContext
        
        let newGallery = NSEntityDescription.insertNewObject(forEntityName: "Gallery", into: Context)
        
        // Atributes
        
        newGallery.setValue(name.text!, forKey: "name")
        newGallery.setValue(caption.text!, forKey: "caption")
        newGallery.setValue(UUID(), forKey: "id")
        
        let imgData = image.image!.jpegData(compressionQuality: 0.5)
        
        newGallery.setValue(imgData, forKey: "image")
        
        
        do{
            try Context.save()
            print("Success!!")
        } catch{
        print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("updatedData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func hideKeyBoard (){
        
        view.endEditing(true)
    }
    
}
