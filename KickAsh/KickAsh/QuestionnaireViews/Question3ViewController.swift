//
//  Question3ViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-09.
//

import UIKit

class Question3ViewController: UIViewController {
    
    var username :String!
    var selectedButtonColor : UIColor!
    var nextButtonColor : UIColor!
    
    @IBOutlet weak var option1Text : UIButton!
    @IBOutlet weak var option2Text : UIButton!
    @IBOutlet weak var option3Text : UIButton!
    @IBOutlet weak var nextButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        username = UserDefaults.standard.string(forKey: "Username")

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
            UserDefaults.standard.set(option1Text.titleLabel?.text, forKey: QuestionnaireDataKey.question3 + username)
            updateUserProfile(with: option1Text.titleLabel?.text ?? "")
        }
        else if (option2Text.backgroundColor == selectedButtonColor){
            UserDefaults.standard.set(option2Text.titleLabel?.text, forKey: QuestionnaireDataKey.question3 + username)
            updateUserProfile(with: option2Text.titleLabel?.text ?? "")
        }
        else if (option3Text.backgroundColor == selectedButtonColor){
            UserDefaults.standard.set(option3Text.titleLabel?.text, forKey: QuestionnaireDataKey.question3 + username)
            updateUserProfile(with: option3Text.titleLabel?.text ?? "")
        }
        else {
            sender.isEnabled = false
            nextButton.backgroundColor = UIColor.systemGray6
        }
        
//        let answer = UserDefaults.standard.string(forKey: QuestionnaireDataKey.question3 + username)
//        print("Answer 3 : ", answer)
    }
    
    func updateUserProfile(with options: String) {
        // Fetch userId from UserDefaults
        guard let userId = UserDefaults.standard.string(forKey: "UserId") else {
            print("User ID not found")
            return
        }

        // Construct API endpoint for updating the user profile
        guard let url = URL(string: "https://api-kickash-8fefbb641f24.herokuapp.com/profile/\(userId)/edit") else {
            print("Invalid API endpoint")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT" // Assuming your API uses POST to update user profiles
        
        // Prepare the body of the request with the questionnaire data
        let requestBody = ["gender": options]

        do {
            // Convert the data to JSON format
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: [])
            
            // Attach the JSON data to the request
            request.httpBody = jsonData

            // Set headers and make the API call
            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Assuming JSON is expected
            // Add authentication token if required
            let authToken = UserDefaults.standard.string(forKey: "AuthToken")
            request.setValue("Bearer \(authToken ?? "")", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { data, response, error in
                // Handle the response from the API call
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response")
                    return
                }
                
                if (200...299).contains(httpResponse.statusCode) {
                    // Successful update
                    print("User profile updated successfully")
                } else {
                    // Handle other status codes
                    print("Unexpected status code: \(httpResponse.statusCode)")
                }
            }.resume()
        } catch {
            print("Error preparing request: \(error)")
        }
    }
}



////Constant for Key in User Defaults
//struct Question3DataKey{
//    static let question3 = "What is your gender? - "
//}

