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
    
    @IBOutlet weak var option1Text: UILabel!
    
    @IBOutlet weak var option2Text: UILabel!
    
    @IBOutlet weak var option3Text: UILabel!
    
    @IBOutlet weak var option4Text: UILabel!
    
    @IBOutlet weak var option5Text: UILabel!
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
        }
    
    @IBAction func checkbox1Selected(_ sender: UIButton) {
        if(!option1Selected){
            sender.backgroundColor = UIColor.systemPurple
            option1Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option1Selected = false
        }
    }
    
    @IBAction func checkbox2Selected(_ sender: UIButton) {
        if(!option2Selected){
            sender.backgroundColor = UIColor.systemPurple
            option2Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option2Selected = false
        }
    }

    @IBAction func checkbox3Selected(_ sender: UIButton) {
        if(!option3Selected){
            sender.backgroundColor = UIColor.systemPurple
            option3Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option3Selected = false
        }
    }

    @IBAction func checkbox4Selected(_ sender: UIButton) {
        if(!option4Selected){
            sender.backgroundColor = UIColor.systemPurple
            option4Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option4Selected = false
        }
    }

    @IBAction func checkbox5Selected(_ sender: UIButton) {
        if(!option5Selected){
            sender.backgroundColor = UIColor.systemPurple
            option5Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option5Selected = false
        }
    }
        
    @IBAction func nextQuestion(_ sender: UIButton) {
        var optionSelected : String = ""
        
        if(option1Selected){
            optionSelected = option1Text.text!
        }
        
        print(optionSelected)
    }
}
