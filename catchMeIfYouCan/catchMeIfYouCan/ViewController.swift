//
//  ViewController.swift
//  catchMeIfYouCan
//
//  Created by Abdullah Mohammed on 23/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit
import AVFoundation


class MyTapGestureRecognizer: UITapGestureRecognizer {
    var img = UIImageView()
}

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
    
    var audioPlayer : AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //sound
        let sound = Bundle.main.url(forResource: "punch", withExtension: "mp3")
          
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound!)
        
        } catch {
            print("audio file error")
        }
        
        
               jerryArr = [jerry1,jerry2,jerry3,jerry4,jerry5,jerry6,jerry7,jerry8,jerry9]
        
        let storeHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if storeHighScore != nil {
            highscore.text = "HighestScore : \(storeHighScore ?? "")"
            highScoreCount = storeHighScore as! Int
        }else{
             highscore.text = "HighestScore : 0"
        }
        
        score.text = "Your score : \(scoreCount )"
        
       // Tap Gesture for each handler
        // adding Gesture for each jerry imageview
     
        for jerry in jerryArr {
            
            let gestureRecognizer = MyTapGestureRecognizer(target: self, action: #selector(incScore))
                jerry.addGestureRecognizer(gestureRecognizer)
            gestureRecognizer.img = jerry
        }
        
        // enabling interactive in each imageview
    
        for jerry in jerryArr {
                   jerry.isUserInteractionEnabled = true
               }
        
        
        // Timers
        
        timer.text = String(timeCount)
        
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decreaseTimeCount), userInfo: nil, repeats: true)
        
        
        timerHidder = Timer.scheduledTimer(timeInterval: 0.7, target: self, selector:#selector(hideImage), userInfo: nil, repeats: true)
        
    }
    
    // increase the score
    @objc func incScore (gestureRecognizer: MyTapGestureRecognizer){
        
        scoreCount += 1
        score.text = "Your score : \(scoreCount)"
        gestureRecognizer.img.image = UIImage(named:"jerry_sad")
        
      

        

        audioPlayer?.play()
        
        self.view.backgroundColor = UIColor(red:1.00, green:0.45, blue:0.45, alpha:1.0)
        timer.textColor = UIColor.white
        score.textColor = UIColor.white
        highscore.textColor = UIColor.white
      
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { (Timer) in
            self.view.backgroundColor = UIColor.white
            self.timer.textColor = UIColor.black
            self.score.textColor = UIColor.black
            self.highscore.textColor = UIColor.black
            
            gestureRecognizer.img.image = UIImage(named:"jerry")
        }
        
        
    }
    
    // hide all image init
    @objc func hideImage(){
        
        for jerry in jerryArr {
            jerry.isHidden = true
        }
        
       let random = Int(arc4random_uniform(UInt32(jerryArr.count - 1)))
        
        jerryArr[random].isHidden = false
        
    }
    
    
    // decrease time counting (9,8,7,6 ....) with are functionality
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
                self.score.text = "Your score : \(self.scoreCount)"
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

