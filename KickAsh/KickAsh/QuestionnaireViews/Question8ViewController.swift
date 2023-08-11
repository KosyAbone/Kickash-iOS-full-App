//
//  Question8ViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-09.
//

import UIKit

class Question8ViewController: UIViewController {
    
    var username : String!
    var finalGoalDate : Date!
    
    @IBOutlet weak var goalDate: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        username = UserDefaults.standard.string(forKey: "Username")
        finalGoalDate = goalDate.date
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func setGoal(_ sender: UIDatePicker) {
        finalGoalDate = sender.date
        //print("Goal: ", goalDate)
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        UserDefaults.standard.set(finalGoalDate, forKey: QuestionnaireDataKey.question8 + username)
        
        //print("Goal: ", finalGoalDate)
    }
    
}
