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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func option1Selected(_ sender: UIButton) {
        if(!option1Selected){
            sender.backgroundColor = UIColor.systemPurple
            option1Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option1Selected = false
        }
    }
    
    @IBAction func option2Selected(_ sender: UIButton){
        if(!option2Selected){
            sender.backgroundColor = UIColor.systemPurple
            option2Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option2Selected = false
        }
    }
    
    @IBAction func option3Selected(_ sender: UIButton){
        if(!option3Selected){
            sender.backgroundColor = UIColor.systemPurple
            option3Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option3Selected = false
        }
    }
    
    @IBAction func option4Selected(_ sender: UIButton){
        if(!option4Selected){
            sender.backgroundColor = UIColor.systemPurple
            option4Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option4Selected = false
        }
    }
    
    @IBAction func option5Selected(_ sender: UIButton){
        if(!option5Selected){
            sender.backgroundColor = UIColor.systemPurple
            option5Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option5Selected = false
        }
    }
    
    @IBAction func option6Selected(_ sender: UIButton){
        if(!option6Selected){
            sender.backgroundColor = UIColor.systemPurple
            option6Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option6Selected = false
        }
    }
    
    @IBAction func option7Selected(_ sender: UIButton){
        if(!option7Selected){
            sender.backgroundColor = UIColor.systemPurple
            option7Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option7Selected = false
        }
    }
    
    @IBAction func option8Selected(_ sender: UIButton){
        if(!option8Selected){
            sender.backgroundColor = UIColor.systemPurple
            option8Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option8Selected = false
        }
    }
    
    @IBAction func option9Selected(_ sender: UIButton){
        if(!option9Selected){
            sender.backgroundColor = UIColor.systemPurple
            option9Selected = true
        }
        else {
            sender.backgroundColor = UIColor.clear
            option9Selected = false
        }
    }

    @IBAction func nextQuestion(_ sender: UIButton) {
    }
    
}
