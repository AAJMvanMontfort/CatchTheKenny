//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by AAJM van Montfort on 06/07/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblHighScore: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    let maxCounter = 10
    var counter = 0
    var score = 0
    var highScore = 0
    var whichKennyIsVisible = 0
    var timer = Timer()
    var switchKennyTimer = Timer()
    var kennyArray = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        initKennys()
        initGame()
    }
    
    func initGame() {
        
        if let highScoreStored = UserDefaults.standard.object(forKey: "Highscore") as? Int {
            highScore = highScoreStored
        }

        counter = maxCounter
        score = 0
        lblTimer.text = "\(counter)"
        lblScore.text = "Score: \(score)"
        lblHighScore.text = "Highscore: \(highScore)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(catchKenny), userInfo: nil, repeats: true)
        switchKennyTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(showKenny), userInfo: nil, repeats: true)
    }
    
    func initKennys() {
        let recogniser1 = UITapGestureRecognizer(target: self, action: #selector(kennyCaught))
        let recogniser2 = UITapGestureRecognizer(target: self, action: #selector(kennyCaught))
        let recogniser3 = UITapGestureRecognizer(target: self, action: #selector(kennyCaught))
        let recogniser4 = UITapGestureRecognizer(target: self, action: #selector(kennyCaught))
        let recogniser5 = UITapGestureRecognizer(target: self, action: #selector(kennyCaught))
        let recogniser6 = UITapGestureRecognizer(target: self, action: #selector(kennyCaught))
        let recogniser7 = UITapGestureRecognizer(target: self, action: #selector(kennyCaught))
        let recogniser8 = UITapGestureRecognizer(target: self, action: #selector(kennyCaught))
        let recogniser9 = UITapGestureRecognizer(target: self, action: #selector(kennyCaught))
        
        kenny1.addGestureRecognizer(recogniser1)
        kenny2.addGestureRecognizer(recogniser2)
        kenny3.addGestureRecognizer(recogniser3)
        kenny4.addGestureRecognizer(recogniser4)
        kenny5.addGestureRecognizer(recogniser5)
        kenny6.addGestureRecognizer(recogniser6)
        kenny7.addGestureRecognizer(recogniser7)
        kenny8.addGestureRecognizer(recogniser8)
        kenny9.addGestureRecognizer(recogniser9)
        
        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        hideKennys()
    }
    
    func hideKennys() {
        for kenny in kennyArray {
            kenny.alpha = 0
        }
    }
    
    @objc func showKenny() {
        let maxKenny = kennyArray.count
        var random = Int(arc4random_uniform(UInt32(maxKenny)))
          
        //DIsable active Kenny
        kennyArray[whichKennyIsVisible].alpha = 0
        kennyArray[whichKennyIsVisible].isUserInteractionEnabled = false
        
        while whichKennyIsVisible == random {
            random = Int(arc4random_uniform(UInt32(maxKenny)))
        }
         
        whichKennyIsVisible = random
      
        //Activate new Kenny
        kennyArray[whichKennyIsVisible].alpha = 1
        kennyArray[whichKennyIsVisible].isUserInteractionEnabled = true
    }
    
    @objc func catchKenny() {
        
        counter -= 1
        lblTimer.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            switchKennyTimer.invalidate()
            
            let alert = UIAlertController(title: "Time's up!", message: "Do you want to play again?", preferredStyle: UIAlertController.Style.alert)
            let noButton = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                self.initGame()
            }
            
            alert.addAction(noButton)
            alert.addAction(replayButton)
            self.present(alert, animated: true , completion: nil)

            lblTimer.text = "Time's over!"
        }
    }
    
    @objc func kennyCaught() {
        score += 1
        lblScore.text = "Score: \(score)"
        
        if score > highScore {
            UserDefaults.standard.set(score, forKey: "Highscore")
            lblHighScore.text = "Highscore: \(highScore)"
        }
    }
    

}

