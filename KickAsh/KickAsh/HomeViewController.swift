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
    
    var cigarettesSmoked : Int!
//
//    var goalDays : Int!
//
//    var cigarettesSmokedInPast : Int!
//
//    var cigarettesAllowed : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var username = UserDefaults.standard.string(forKey: "Username") ?? nil
        
//        cigarettesSmokedInPast = UserDefaults.standard.integer(forKey: QuestionnaireDataKey.question2 + username!)
//
//        var userGoal = UserDefaults.standard.object(forKey: QuestionnaireDataKey.question8 + username!) as! Date
//        getGoalDays(userGoal)
//
//        getCustomisation()
//
//        var cigNumber = String(cigarettesAllowed)
//        warningText.text = "Only smoke " + cigNumber + " cigarettes today"
//
//        if(username != nil){
//            var counter = UserDefaults.standard.integer(forKey: "Cigarettes Smoked" + username!)
//            if (counter != 0){
//                cigarettesSmoked = counter
//                if(cigarettesSmoked > cigarettesAllowed){
//                    warningText.textColor = UIColor.red
//                }
//            }
//            else{
//                counter = counter + 1
//                UserDefaults.standard.set(counter, forKey: "Cigarettes Smoked" + username!)
//            }
//        }
//
        print("View Loaded")
    }
    
    
    @IBAction func smokeCounter(_ sender: UIButton) {
        cigarettesSmoked += 1
        smokeCounterLabel.text = String(cigarettesSmoked)
        
        if(cigarettesSmoked >= 5){
            warningText.textColor = UIColor.red
        }
        
    }
    
//    func getGoalDays(_ userGoal : Date){
//        var todayDate = Date()
//
//        let calendar = Calendar.current
//        let dateComponents = calendar.dateComponents([.day], from: todayDate, to: userGoal)
//
//        goalDays = dateComponents.day
//
//        print("Goal Days!!!", String(goalDays))
//    }
//
//    func getCustomisation(){
//        while(cigarettesSmokedInPast != nil){
//            if(goalDays <= 10){
//                cigarettesAllowed = 0
//            }
//            else if (goalDays > 10 && goalDays <= 20){
//                cigarettesAllowed = 1
//            }
//            else if (goalDays > 20 && goalDays <= 30){
//                cigarettesAllowed = 2
//                if(cigarettesAllowed > cigarettesSmokedInPast){
//                    cigarettesAllowed = cigarettesSmokedInPast
//                }
//            }
//            else if (goalDays > 30 && goalDays <= 40){
//                cigarettesAllowed = 3
//                if(cigarettesAllowed > cigarettesSmokedInPast){
//                    cigarettesAllowed = cigarettesSmokedInPast
//                }
//            }
//            else if (goalDays > 40 && goalDays <= 50){
//                cigarettesAllowed = 4
//                if(cigarettesAllowed > cigarettesSmokedInPast){
//                    cigarettesAllowed = cigarettesSmokedInPast
//                }
//            }
//            else if (goalDays > 50 && goalDays <= 60){
//                cigarettesAllowed = 5
//                if(cigarettesAllowed > cigarettesSmokedInPast){
//                    cigarettesAllowed = cigarettesSmokedInPast
//                }
//            }
//            else if (goalDays > 60 && goalDays <= 70){
//                cigarettesAllowed = 6
//                if(cigarettesAllowed > cigarettesSmokedInPast){
//                    cigarettesAllowed = cigarettesSmokedInPast
//                }
//            }
//            else if (goalDays > 70 && goalDays <= 80){
//                cigarettesAllowed = 7
//                if(cigarettesAllowed > cigarettesSmokedInPast){
//                    cigarettesAllowed = cigarettesSmokedInPast
//                }
//            }
//            else if (goalDays > 80 && goalDays <= 90){
//                cigarettesAllowed = 8
//                if(cigarettesAllowed > cigarettesSmokedInPast){
//                    cigarettesAllowed = cigarettesSmokedInPast
//                }
//            }
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
