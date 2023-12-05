//
//  ProfileViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-11.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @IBOutlet weak var profileImageView: UIImageView!
        @IBOutlet weak var displayNameTextField: UITextField!
        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var genderTextField: UITextField!
        @IBOutlet weak var dateOfBirthTextField: UITextField!
        @IBOutlet weak var smokingAgeTextField: UITextField!
        @IBOutlet weak var noOfCigarPerDayTextField: UITextField!
        @IBOutlet weak var dateJoinedLabel: UILabel!
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            fetchUserProfile()
        }
    
        //To Get the User Profile details and Update the UI
        func fetchUserProfile() {
            // Perform API call to fetch user profile data
            guard let url = URL(string: "https://api-kickash-8fefbb641f24.herokuapp.com/profile") else {
                print("Invalid API endpoint")
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            // Get the JWT token from UserDefaults (stored after login/authentication)
            let token = UserDefaults.standard.string(forKey: "AuthToken")
            
            // Set the JWT token in the Authorization header
            request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let data = data, error == nil else {
                    print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(UserProfile.self, from: data)
                    
                    DispatchQueue.main.async {
                        self?.updateUI(with: result)
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
            
            task.resume()
        }
        
        func updateUI(with profile: UserProfile) {
            // Update profile picture
            if let imageUrl = URL(string: profile.profilePicture.url) {
                URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                    if let error = error {
                        print("Error fetching image: \(error)")
                        return
                    }
                    
                    // Check if data exists and create UIImage
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async { [self] in
                            // Update the UIImageView on the main queue
                            profileImageView.image = image
                        }
                    }
                }.resume()
            }
            
            // Update display name
            displayNameTextField.text = "\(profile.firstName) \(profile.lastName)"
            emailTextField.text = profile.email
            genderTextField.text = UserDefaults.standard.string(forKey: QuestionnaireDataKey.question3 + profile.username)
            smokingAgeTextField.text = UserDefaults.standard.string(forKey: QuestionnaireDataKey.question1 + profile.username)
            noOfCigarPerDayTextField.text = UserDefaults.standard.string(forKey: QuestionnaireDataKey.question2 + profile.username)
            
            // Update date joined
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = formatter.date(from: profile.dateJoined) {
                formatter.dateFormat = "MMM d, yyyy"
                dateJoinedLabel.text = formatter.string(from: date)
            }
            // Update date of birth
            let dobFormatter = DateFormatter()
            dobFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Format from the API response
            if let dobDate = dobFormatter.date(from: profile.dateOfBirth) {
                dobFormatter.dateFormat = "MMM d, yyyy" // Desired display format
                dateOfBirthTextField.text = dobFormatter.string(from: dobDate)
            }
        }
    
    @IBAction func logout(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier:"login")
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.isModalInPresentation = true
        self.present(newViewController, animated: true, completion: nil)
    }

}

    struct UserProfile: Codable {
        let profilePicture: ProfilePicture
        let firstName: String
        let lastName: String
        let dateJoined: String
        let email: String
        let username: String
        let dateOfBirth: String
    }

    struct ProfilePicture: Codable {
        let url: String
        let publicId: String
    }
    
    // Model for upload response
    struct UploadResponse: Codable {
        let message: String
        let profileImageUrl: String
        let success: Bool
    }

    // Extension to append string to NSMutableData
    extension NSMutableData {
        func appendString(_ string: String) {
            if let data = string.data(using: .utf8) {
                append(data)
            }
        }
    }
