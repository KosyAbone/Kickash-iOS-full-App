//
//  HomeViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-10.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var smokingCounter: UIButton!
    
    @IBOutlet weak var smokeCounterLabel: UILabel!
    
    @IBOutlet weak var warningText: UILabel!
    
    @IBOutlet weak var smokeFreeTimerLabel: UILabel!
    
    var cigarettesSmoked : Int!

    var goalDays : Int!

    var cigarettesSmokedInPast : Int!

    var cigarettesAllowed : Int!
    
    var lastSmoked : Date!
    
    var timer: Timer?
    var smokeFreeCounter: Int = 0
    var username : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer()
        
        username = UserDefaults.standard.string(forKey: "Username") ?? nil
        
        cigarettesSmokedInPast = UserDefaults.standard.integer(forKey: QuestionnaireDataKey.question2 + username!)

        var userGoal = UserDefaults.standard.object(forKey: QuestionnaireDataKey.question8 + username!) as! Date
        getGoalDays(userGoal)

        getCustomisation()

        let cigNumber = String(cigarettesAllowed)
        let displayText = "Only smoke " + cigNumber + " cigarettes today"
        warningText.text = displayText

        if(username != nil){
            var counter = UserDefaults.standard.integer(forKey: "Cigarettes Smoked" + username!)
            print(counter)
            if (counter != 0){
                cigarettesSmoked = counter
                if(cigarettesSmoked > cigarettesAllowed){
                    warningText.textColor = UIColor.red
                }
                smokeCounterLabel.text = String(cigarettesSmoked)
            }
            else{
                counter = counter + 1
                cigarettesSmoked = counter
                UserDefaults.standard.set(counter, forKey: "Cigarettes Smoked" + username!)
            }
        }

        print("View Loaded")
    }
    
    
    @IBAction func smokeCounter(_ sender: UIButton) {
        cigarettesSmoked += 1
        smokeCounterLabel.text = String(cigarettesSmoked)
        
        if(cigarettesSmoked >= cigarettesAllowed){
            warningText.textColor = UIColor.red
        }
        
        UserDefaults.standard.set(cigarettesSmoked, forKey: "Cigarettes Smoked" + username!)
        
        resetTimer()
    }
    
    func getGoalDays(_ userGoal : Date){
        let todayDate = Date()

        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day], from: todayDate, to: userGoal)

        goalDays = dateComponents.day

        print("Goal Days!!!", String(goalDays))
    }

    func getCustomisation(){
        if(cigarettesSmokedInPast != nil){
            if(goalDays <= 10){
                cigarettesAllowed = 0
            }
            else if (goalDays > 10 && goalDays <= 20){
                cigarettesAllowed = 1
            }
            else if (goalDays > 20 && goalDays <= 30){
                cigarettesAllowed = 2
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 30 && goalDays <= 40){
                cigarettesAllowed = 3
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 40 && goalDays <= 50){
                cigarettesAllowed = 4
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 50 && goalDays <= 60){
                cigarettesAllowed = 5
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 60 && goalDays <= 70){
                cigarettesAllowed = 6
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 70 && goalDays <= 80){
                cigarettesAllowed = 7
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
            else if (goalDays > 80 && goalDays <= 90){
                cigarettesAllowed = 8
                if(cigarettesAllowed > cigarettesSmokedInPast){
                    cigarettesAllowed = cigarettesSmokedInPast
                }
            }
        }
    }


    //starting smoke free timer
    func startTimer() {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        }
    
    //timer value
    @objc func updateCounter() {
           smokeFreeCounter += 1
           updateTimerLabel()
       }
    
    //reset timer to 0 on click
    func resetTimer() {
            timer?.invalidate()
            smokeFreeCounter = 0
            updateTimerLabel()
            startTimer()
        }
    
    func updateTimerLabel() {
            let hours = smokeFreeCounter / 3600
            let minutes = (smokeFreeCounter % 3600) / 60
            let seconds = smokeFreeCounter % 60
            
            smokeFreeTimerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }

}
