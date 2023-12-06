//
//  ProfileViewController.swift
//  KickAsh
//
//  Created by Kossy on 2023-12-05.
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
    
        
        var userId: String? // This will store the user's ID fetched from the profile
        
        override func viewDidLoad() {
            super.viewDidLoad()
            retrieveProfileImageFromLocal()
            fetchUserProfile()
        }
    
        @IBAction func changeProfilePictureButtonTapped(_ sender: UIButton) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                present(imagePicker, animated: true, completion: nil)
        }
    
        
        
    
        //To retrieve available picture from local data
        func retrieveProfileImageFromLocal() {
            if let profilePicURLString = UserDefaults.standard.string(forKey: "profilePicURL" ),
               let profilePicURL = URL(string: profilePicURLString) {
                
                let task = URLSession.shared.dataTask(with: profilePicURL) { [weak self] data, response, error in
                    guard let data = data, error == nil else {
                        print("Error loading image data: \(error?.localizedDescription ?? "Unknown error")")
                        // If there's an error loading the local image, fetch from server
                        self?.fetchUserProfile()
                        return
                    }
                    
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.profileImageView.image = image
                        }
                    }
                }
                task.resume()
            } else {
                // If no local image found, fetch from server
                fetchUserProfile()
            }
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
                    // Store the user's ID for later use
                    self?.userId = result._id
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
            
            // Update the different profile information fields
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

    
    func uploadProfilePicture(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Error converting image to data")
            return
        }
        
        // Construct URL with userId retrieved after getting user profile
        let id = userId!
        let uploadURLString = "https://api-kickash-8fefbb641f24.herokuapp.com/profile/\(id)/upload"

        guard let url = URL(string: uploadURLString) else {
            print("Invalid API endpoint")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        let token = UserDefaults.standard.string(forKey: "AuthToken")
        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        let body = NSMutableData()
        let boundaryPrefix = "--\(boundary)\r\n"

        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"profilePicture\"; filename=\"profile.jpg\"\r\n")
        body.appendString("Content-Type: image/jpeg\r\n\r\n")
        body.append(imageData)
        body.appendString("\r\n")

        body.appendString("--\(boundary)--\r\n")
        request.httpBody = body as Data

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error uploading profile picture: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoder = JSONDecoder()
                let uploadResult = try decoder.decode(UploadResponse.self, from: data)

                // Save profile image data to disk
                if let imageUrl = URL(string: uploadResult.profileImageUrl) {
                    // Save image URL to UserDefaults
                    UserDefaults.standard.set(imageUrl.absoluteString, forKey: "profilePicURL")
                    UserDefaults.standard.synchronize() // Ensure UserDefaults is immediately updated

                    // Update UI on the main queue
                    DispatchQueue.main.async {
                        self?.profileImageView.image = image
                    }
                }
            } catch {
                print("Error decoding upload response: \(error)")
            }
        }

        task.resume()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            profileImageView.image = pickedImage
            uploadProfilePicture(image: pickedImage)
        }

        picker.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func logout(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier:"login")
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.isModalInPresentation = true
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func saveImageToDisk(imageData: Data) -> URL? {
        // Create a unique file URL in the Documents directory
        let fileManager = FileManager.default
        do {
            let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileURL = documentsDirectory.appendingPathComponent("profileImage.jpg")

            // Write image data to the file
            try imageData.write(to: fileURL)
            return fileURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
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
        let _id: String
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
