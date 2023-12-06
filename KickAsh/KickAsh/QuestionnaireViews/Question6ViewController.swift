//
//  Question6ViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-08.
//

import UIKit

class Question6ViewController: UIViewController {
    
    var option1Selected : Bool = false
    var option2Selected : Bool = false
    var option3Selected : Bool = false
    var option4Selected : Bool = false
    var option5Selected : Bool = false
    var checkboxColor : UIColor!
    var username : String!
    var nextButtonColor : UIColor!
    
    @IBOutlet weak var option1Text: UILabel!
        
    @IBOutlet weak var option2Text: UILabel!
        
    @IBOutlet weak var option3Text: UILabel!
        
    @IBOutlet weak var option4Text: UILabel!
        
    @IBOutlet weak var option5Text: UILabel!
        
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        username = UserDefaults.standard.string(forKey: "Username")
            
        let boxColor = "#6750A4"
        if let color = UIColor(hexString: boxColor){
            checkboxColor = color
        }
            
        let nextColor = "#6750A4"
        if let color = UIColor(hexString: nextColor){
            nextButtonColor = color
        }
    }
    
    @IBAction func checkbox1Selected(_ sender: UIButton) {
        if(!option1Selected){
            sender.backgroundColor = checkboxColor
            option1Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option1Selected = false
            
            if(!option2Selected && !option3Selected && !option4Selected && !option5Selected){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func checkbox2Selected(_ sender: UIButton) {
        if(!option2Selected){
            sender.backgroundColor = checkboxColor
            option2Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option2Selected = false
            
            if(!option1Selected && !option3Selected && !option4Selected && !option5Selected){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func checkbox3Selected(_ sender: UIButton) {
        if(!option3Selected){
            sender.backgroundColor = checkboxColor
            option3Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option3Selected = false
            
            if(!option1Selected && !option2Selected && !option4Selected && !option5Selected){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func checkbox4Selected(_ sender: UIButton) {
        if(!option4Selected){
            sender.backgroundColor = checkboxColor
            option4Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option4Selected = false
            
            if(!option1Selected && !option2Selected && !option3Selected && !option5Selected){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func checkbox5Selected(_ sender: UIButton) {
        if(!option5Selected){
            sender.backgroundColor = checkboxColor
            option5Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option5Selected = false
            
            if(!option1Selected && !option2Selected && !option3Selected && !option4Selected){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        var optionSelected : String = ""
        
        if(option1Selected){
            optionSelected = option1Text.text!
        }
        if(option2Selected){
            if(optionSelected != ""){
                optionSelected += "," + option2Text.text!
            }
            else {
                optionSelected = option2Text.text!
            }
        }
        if(option3Selected){
            if(optionSelected != ""){
                optionSelected += "," + option3Text.text!
            }
            else {
                optionSelected = option3Text.text!
            }
        }
        if(option4Selected){
            if(optionSelected != ""){
                optionSelected += "," + option4Text.text!
            }
            else {
                optionSelected = option4Text.text!
            }
        }
        if(option5Selected){
            if(optionSelected != ""){
                optionSelected += "," + option5Text.text!
            }
            else {
                optionSelected = option5Text.text!
            }
        }
        
        UserDefaults.standard.set(optionSelected, forKey: QuestionnaireDataKey.question6 + username)
        
        print(optionSelected)
    }
    
}
