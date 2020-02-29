//
//  UploadViewController.swift
//  instaClone
//
//  Created by Abdullah Mohammed on 27/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController ,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTx: UITextField!
    @IBOutlet weak var uploadBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
        uploadBtn.layer.borderWidth = 2
        uploadBtn.layer.borderColor = UIColor.blue.cgColor
    }
    
    @objc func chooseImage(){
        let pickerImg = UIImagePickerController()
               
               pickerImg.delegate = self
               pickerImg.sourceType = .photoLibrary
               present(pickerImg, animated: true, completion: nil)
    }

    @IBAction func uploadEvent(_ sender: Any) {
        
        let uuid = UUID().uuidString
        let storageRef = Storage.storage().reference()
        
        let mediaFolder = storageRef.child("media")
        
        if let imgData = imageView.image?.jpegData(compressionQuality: 0.5){
            
            let imgRef = mediaFolder.child("\(uuid).jpg")
            imgRef.putData(imgData, metadata: nil) { (metaData, error) in
                
                if error != nil{
                    self.alertEvent(alertTitle: "Error", alertMessage: error!.localizedDescription)
                }else{
                    
                    imgRef.downloadURL { (url, error) in
                        
                        if error == nil{
                            
                            let imgUrl = url?.absoluteString
                            
                            
                            //DataBase with fireStore
                            
                            let fireDB = Firestore.firestore()
                            
                            var fireRef : DocumentReference? = nil
                            let firePost = ["ImgUrl" : imgUrl!, "PostBy" : Auth.auth().currentUser?.email as Any,"PostComment" : self.commentTx.text as Any , "Date": FieldValue.serverTimestamp(),"Likes" : 0 ] as [String : Any]
                            
                            fireRef = fireDB.collection("Posts").addDocument(data: firePost, completion: { (error) in
                                
                                if error != nil {
                                    self.alertEvent(alertTitle: "Error", alertMessage: error!.localizedDescription)
                                }else{
                                    self.imageView.image = UIImage(named: "selectImg.jpeg")
                                    self.commentTx.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                            
                        }
                    }
                }
                
            }
        }
        
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
      func alertEvent(alertTitle:String,alertMessage:String){
          let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
          let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
          
          alert.addAction(okBtn)
          self.present(alert, animated: true, completion: nil)
      }
    
    

}
