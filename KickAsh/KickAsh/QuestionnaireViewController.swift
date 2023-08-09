//
//  QuestionnaireViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-08.
//

import UIKit

class QuestionnaireViewController: UIViewController {
    
    @IBOutlet weak var option1Text : UIButton!
    @IBOutlet weak var option2Text : UIButton!
    @IBOutlet weak var option3Text : UIButton!

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

    @IBAction func selectOption1(_ sender: UIButton) {
        if sender.isSelected {
            sender.backgroundColor = UIColor.blue
            sender.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    @IBAction func selectOption2(_ sender: UIButton) {
    }
    
    @IBAction func selectOption3(_ sender: UIButton) {
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
    }
}
