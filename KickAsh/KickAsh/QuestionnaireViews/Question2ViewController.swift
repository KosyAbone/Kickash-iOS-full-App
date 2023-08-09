//
//  Question2ViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-09.
//

import UIKit

class Question2ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var numberText : UITextField!
    @IBOutlet weak var numberStepper : UIStepper!

    override func viewDidLoad() {
        super.viewDidLoad()

        numberText.delegate = self
        numberStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let allowedCharacters = CharacterSet(charactersIn: "0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
    }
    
    @IBAction func numberChanged(_ sender: UITextField) {
        if let text = sender.text, let value = Int(text){
            numberStepper.value = Double(value)
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        numberText.text = String(Int(sender.value))
    }
}
