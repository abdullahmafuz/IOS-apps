//
//  ViewController.swift
//  catchMeIfYouCan
//
//  Created by Abdullah Mohammed on 23/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // UI selection
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var highscore: UILabel!
    @IBOutlet weak var jerry1: UIImageView!
    @IBOutlet weak var jerry2: UIImageView!
    @IBOutlet weak var jerry3: UIImageView!
    @IBOutlet weak var jerry4: UIImageView!
    @IBOutlet weak var jerry5: UIImageView!
    @IBOutlet weak var jerry6: UIImageView!
    @IBOutlet weak var jerry7: UIImageView!
    @IBOutlet weak var jerry8: UIImageView!
    @IBOutlet weak var jerry9: UIImageView!
    
    
    // Global variable decleration
    var scoreCount = 0
    var timeCount = 30
    var highScoreCount = 0
    var time = Timer()
    var timerHidder = Timer()
    
    var jerryArr = [UIImageView]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
               jerryArr = [jerry1,jerry2,jerry3,jerry4,jerry5,jerry6,jerry7,jerry8,jerry9]
        
        let storeHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storeHighScore != nil {
            highscore.text = "HighScore : \(storeHighScore ?? "")"
            highScoreCount = storeHighScore as! Int
        }else{
             highscore.text = "HighScore : 0"
        }
        
        score.text = "Score : \(scoreCount )"
        
       // Tap Gesture for each handler
        // adding Gesture for each jerry imageview
     
        for jerry in jerryArr {
            
            jerry.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(incScore)))
            
        }
        
        // enabling interactive in each imageview
    
        for jerry in jerryArr {
                   jerry.isUserInteractionEnabled = true
               }
        
        
        // Timers
        
        timer.text = String(timeCount)
        
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimeCount), userInfo: nil, repeats: true)
        
        
        timerHidder = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:#selector(hideImage), userInfo: nil, repeats: true)
        
    }
    
    @objc func incScore (){
        
        scoreCount += 1
        score.text = "Score : \(scoreCount)"
        
    }
    @objc func hideImage(){
        
        for jerry in jerryArr {
            jerry.isHidden = true
        }
        
       let random = Int(arc4random_uniform(UInt32(jerryArr.count - 1)))
        
        jerryArr[random].isHidden = false
        
    }
    
    @objc func decreaseTimeCount (){
        
        timeCount -= 1
        timer.text = String(timeCount)
        
        if timeCount == 0 {
            
            time.invalidate()
            timerHidder.invalidate()
            
            for jerry in jerryArr {
                       jerry.isHidden = true
                   }
            
            
            
            // highscore
            
            if scoreCount > highScoreCount {
                highScoreCount = scoreCount
                highscore.text = "HighScore : \(highScoreCount)"
                UserDefaults.standard.set(highScoreCount, forKey: "highScore")
            }
            
            
            // alert
            
            let alert = UIAlertController(title: "Time's up", message:"Do you want to retry ?", preferredStyle: UIAlertController.Style.alert)
            
            let okBtn = UIAlertAction(title: "NO", style: UIAlertAction.Style.default, handler: nil)
            
            let tryAgain = UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                // try agian function code here
                self.timeCount = 30
                self.scoreCount = 0
                self.score.text = "Score : \(self.scoreCount)"
                self.timer.text = "30"
                self.time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decreaseTimeCount), userInfo: nil, repeats: true)
                       
                       
                self.timerHidder = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector:#selector(self.hideImage), userInfo: nil, repeats: true)
         
                
            }
            
            alert.addAction(okBtn)
            alert.addAction(tryAgain)
            
            self.present(alert, animated: true, completion: nil)
        }
        
    }


}

