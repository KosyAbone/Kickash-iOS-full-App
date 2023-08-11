//
//  Question7ViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-09.
//

import UIKit

class Question7ViewController: UIViewController {
    
    var option1Selected : Bool = false
    var option2Selected : Bool = false
    var option3Selected : Bool = false
    var option4Selected : Bool = false
    var option5Selected : Bool = false
    var option6Selected : Bool = false
    var option7Selected : Bool = false
    var option8Selected : Bool = false
    var option9Selected : Bool = false
    var checkboxColor : UIColor!
    var username : String!
    var nextButtonColor : UIColor!
    
    @IBOutlet weak var option1Text: UILabel!
    
    @IBOutlet weak var option2Text: UILabel!
    
    @IBOutlet weak var option3Text: UILabel!
    
    @IBOutlet weak var option4Text: UILabel!
    
    @IBOutlet weak var option5Text: UILabel!
    
    @IBOutlet weak var option6Text: UILabel!
    
    @IBOutlet weak var option7Text: UILabel!
    
    @IBOutlet weak var option8Text: UILabel!
    
    @IBOutlet weak var option9Text: UILabel!
    
    @IBOutlet weak var otherHobbyText: UITextField!
    
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
    
    
    @IBAction func option1Selected(_ sender: UIButton) {
        if(!option1Selected){
            sender.backgroundColor = checkboxColor
            option1Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option1Selected = false
            
            if(!option2Selected && !option3Selected && !option4Selected && !option5Selected && !option6Selected && !option7Selected && !option8Selected && !option9Selected && (otherHobbyText.text?.count == 0)){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func option2Selected(_ sender: UIButton){
        if(!option2Selected){
            sender.backgroundColor = checkboxColor
            option2Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option2Selected = false
            
            if(!option1Selected && !option3Selected && !option4Selected && !option5Selected && !option6Selected && !option7Selected && !option8Selected && !option9Selected && (otherHobbyText.text?.count == 0)){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func option3Selected(_ sender: UIButton){
        if(!option3Selected){
            sender.backgroundColor = checkboxColor
            option3Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option3Selected = false
            
            if(!option1Selected && !option2Selected && !option4Selected && !option5Selected && !option6Selected && !option7Selected && !option8Selected && !option9Selected && (otherHobbyText.text?.count == 0)){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func option4Selected(_ sender: UIButton){
        if(!option4Selected){
            sender.backgroundColor = checkboxColor
            option4Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option4Selected = false
            
            if(!option1Selected && !option2Selected && !option3Selected && !option5Selected && !option6Selected && !option7Selected && !option8Selected && !option9Selected && (otherHobbyText.text?.count == 0)){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func option5Selected(_ sender: UIButton){
        if(!option5Selected){
            sender.backgroundColor = checkboxColor
            option5Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option5Selected = false
            
            if(!option1Selected && !option2Selected && !option3Selected && !option4Selected && !option6Selected && !option7Selected && !option8Selected && !option9Selected && (otherHobbyText.text?.count == 0)){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func option6Selected(_ sender: UIButton){
        if(!option6Selected){
            sender.backgroundColor = checkboxColor
            option6Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option6Selected = false
            
            if(!option1Selected && !option2Selected && !option3Selected && !option4Selected && !option5Selected && !option7Selected && !option8Selected && !option9Selected && (otherHobbyText.text?.count == 0)){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func option7Selected(_ sender: UIButton){
        if(!option7Selected){
            sender.backgroundColor = checkboxColor
            option7Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option7Selected = false
            
            if(!option1Selected && !option2Selected && !option3Selected && !option4Selected && !option5Selected && !option6Selected && !option8Selected && !option9Selected && (otherHobbyText.text?.count == 0)){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func option8Selected(_ sender: UIButton){
        if(!option8Selected){
            sender.backgroundColor = checkboxColor
            option8Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option8Selected = false
            
            if(!option1Selected && !option2Selected && !option3Selected && !option4Selected && !option5Selected && !option6Selected && !option7Selected && !option9Selected && (otherHobbyText.text?.count == 0)){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    
    @IBAction func option9Selected(_ sender: UIButton){
        if(!option9Selected){
            sender.backgroundColor = checkboxColor
            option9Selected = true
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.clear
            option9Selected = false
            
            if(!option1Selected && !option2Selected && !option3Selected && !option4Selected && !option5Selected && !option6Selected && !option7Selected && !option8Selected && (otherHobbyText.text?.count == 0)){
                nextButton.isEnabled = false
                nextButton.backgroundColor = UIColor.systemGray6
            }
        }
    }
    @IBAction func otherHobbiesTextField(_ sender: UITextField) {
        if(otherHobbyText.text?.count != 0){
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            if(!option1Selected && !option2Selected && !option3Selected && !option4Selected && !option5Selected && !option6Selected && !option7Selected && !option8Selected && !option9Selected){
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
        if(option6Selected){
            if(optionSelected != ""){
                optionSelected += "," + option6Text.text!
            }
            else {
                optionSelected = option6Text.text!
            }
        }
        if(option7Selected){
            if(optionSelected != ""){
                optionSelected += "," + option7Text.text!
            }
            else {
                optionSelected = option7Text.text!
            }
        }
        if(option8Selected){
            if(optionSelected != ""){
                optionSelected += "," + option8Text.text!
            }
            else {
                optionSelected = option8Text.text!
            }
        }
        if(option9Selected){
            if(optionSelected != ""){
                optionSelected += "," + option9Text.text!
            }
            else {
                optionSelected = option9Text.text!
            }
        }
        if(otherHobbyText.text != nil){
            if(optionSelected != ""){
                optionSelected += "," + otherHobbyText.text!
            }
            else {
                optionSelected = otherHobbyText.text!
            }
        }
        
        UserDefaults.standard.set(optionSelected, forKey: QuestionnaireDataKey.question7 + username)
        
        print("Hobbies: ", UserDefaults.standard.string(forKey: QuestionnaireDataKey.question7 + username)!)
    }
    
}
