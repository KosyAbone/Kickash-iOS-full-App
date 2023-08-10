//
//  Question4ViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-09.
//

import UIKit

class Question4ViewController: UIViewController {
    
    var username = "test"
    var selectedButtonColor : UIColor!
    var nextButtonColor : UIColor!
    
    @IBOutlet weak var option1Text : UIButton!
    @IBOutlet weak var option2Text : UIButton!
    @IBOutlet weak var option3Text : UIButton!
    @IBOutlet weak var nextButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let hexColor = "#8C6EE3"
        if let color = UIColor(hexString: hexColor) {
            selectedButtonColor = color
        }
        
        let nextColor = "#6750A4"
        if let color = UIColor(hexString: nextColor){
            nextButtonColor = color
        }
    }
    
    @IBAction func selectOption1(_ sender: UIButton) {
        if sender.backgroundColor != selectedButtonColor {
            sender.backgroundColor = selectedButtonColor
            sender.titleLabel?.textColor = UIColor.white
            //sender.setTitleColor(UIColor.white, for: .normal)
            
            option2Text.backgroundColor = UIColor.systemGray5
            option2Text.setTitleColor(UIColor.black, for: .normal)
            
            option3Text.backgroundColor = UIColor.systemGray5
            option3Text.setTitleColor(UIColor.black, for: .normal)
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
            
        }
        else {
            sender.backgroundColor = UIColor.systemGray5
            sender.setTitleColor(UIColor.black, for: .normal)
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.systemGray6
        }
    }
    
    @IBAction func selectOption2(_ sender: UIButton) {
        if sender.backgroundColor != selectedButtonColor {
            sender.backgroundColor = selectedButtonColor
            sender.setTitleColor(UIColor.white, for: .selected)
            
            option1Text.backgroundColor = UIColor.systemGray5
            option1Text.setTitleColor(UIColor.black, for: .normal)
            
            option3Text.backgroundColor = UIColor.systemGray5
            option3Text.setTitleColor(UIColor.black, for: .normal)
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.systemGray5
            sender.setTitleColor(UIColor.black, for: .normal)
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.systemGray6
        }
    }
    
    @IBAction func selectOption3(_ sender: UIButton) {
        if sender.backgroundColor != selectedButtonColor {
            sender.backgroundColor = selectedButtonColor
            sender.setTitleColor(UIColor.white, for: .normal)
            
            option1Text.backgroundColor = UIColor.systemGray5
            option1Text.setTitleColor(UIColor.black, for: .normal)
            
            option2Text.backgroundColor = UIColor.systemGray5
            option2Text.setTitleColor(UIColor.black, for: .normal)
            
            nextButton.isEnabled = true
            nextButton.backgroundColor = nextButtonColor
        }
        else {
            sender.backgroundColor = UIColor.systemGray5
            sender.setTitleColor(UIColor.black, for: .normal)
            
            nextButton.isEnabled = false
            nextButton.backgroundColor = UIColor.systemGray6
        }
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        if(option1Text.backgroundColor == selectedButtonColor){
            UserDefaults.standard.set(option1Text.titleLabel?.text, forKey: QuestionnaireDataKey.question4 + username)
        }
        else if (option2Text.backgroundColor == selectedButtonColor){
            UserDefaults.standard.set(option2Text.titleLabel?.text, forKey: QuestionnaireDataKey.question4 + username)
        }
        else if (option3Text.backgroundColor == selectedButtonColor){
            UserDefaults.standard.set(option3Text.titleLabel?.text, forKey: QuestionnaireDataKey.question4 + username)
        }
        else {
            sender.isEnabled = false
            nextButton.backgroundColor = UIColor.systemGray6
        }
    }

}
