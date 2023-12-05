////
////  uploadImage.swift
////  KickAsh
////
////  Created by KOSSY on 2023-12-05.
////
//
//import UIKit
//
//class uploadImage: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//    
//    @IBOutlet weak var profileImageView: UIImageView!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changeProfilePicture(_:)))
//        profileImageView.isUserInteractionEnabled = true
//        profileImageView.addGestureRecognizer(tapGestureRecognizer)
//    }
//    @IBAction func changeProfilePicture(_ sender: UITapGestureRecognizer) {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.allowsEditing = true
//        present(imagePicker, animated: true, completion: nil)
//    }
//    
//    // MARK: - UIImagePickerControllerDelegate methods
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
//            profileImageView.image = pickedImage
//            dismiss(animated: true, completion: nil)
//            
//            // Call function to upload the selected image
//            uploadProfilePicture(image: pickedImage)
//        }
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func uploadProfilePicture(image: UIImage) {
//        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
//        
//        // Retrieve the user ID from the token
//        guard let userId = getUserIdFromToken() else {
//            print("Unable to get user ID")
//            return
//        }
//        
//        // Construct the URL for profile picture upload with the user ID
//        guard let uploadURL = URL(string: "https://api-kickash-8fefbb641f24.herokuapp.com/profile/\(userId)/upload") else {
//            print("Invalid API endpoint")
//            return
//        }
//        
//        var request = URLRequest(url: uploadURL)
//        request.httpMethod = "POST"
//        
//        // Get the JWT token from UserDefaults (stored after login/authentication)
//        let token = UserDefaults.standard.string(forKey: "AuthToken")
//        request.setValue("Bearer \(token ?? "")", forHTTPHeaderField: "Authorization")
//        
//        let boundary = "Boundary-\(UUID().uuidString)"
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        
//        let body = NSMutableData()
//        
//        let boundaryPrefix = "--\(boundary)\r\n"
//        
//        // Image data
//        body.appendString(boundaryPrefix)
//        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"profile.jpg\"\r\n")
//        body.appendString("Content-Type: image/jpeg\r\n\r\n")
//        body.append(imageData)
//        body.appendString("\r\n")
//        
//        body.appendString("--\(boundary)--")
//        
//        request.httpBody = body as Data
//        
//        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            // Handle the API response
//            if let error = error {
//                print("Error: \(error)")
//                return
//            }
//            
//            if let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) {
//                do {
//                    let decoder = JSONDecoder()
//                    let uploadResponse = try decoder.decode(UploadResponse.self, from: data!)
//                    if uploadResponse.success {
//                        // Profile picture updated successfully
//                        print("Profile picture updated: \(uploadResponse.profileImageUrl)")
//                    } else {
//                        print("Profile picture update failed")
//                    }
//                } catch {
//                    print("Error decoding JSON: \(error)")
//                }
//            }
//        }
//        
//        task.resume()
//    }
//}
//
//    func getUserIdFromToken() -> String? {
//        guard let token = UserDefaults.standard.string(forKey: "AuthToken") else {
//            print("Token not found in UserDefaults")
//            return nil
//        }
//
//        print("Token: \(token)")
//
//        let tokenParts = token.components(separatedBy: ".")
//        guard tokenParts.count >= 3 else {
//            print("Invalid token format")
//            return nil
//        }
//
//        let encodedPayload = tokenParts[1]
//        let encodedPayloadPadded = encodedPayload.padding(toLength: ((encodedPayload.count+3)/4)*4,
//                                                         withPad: "=",
//                                                         startingAt: 0)
//
//        guard let decodedData = Data(base64Encoded: encodedPayloadPadded) else {
//            print("Error decoding base64 payload")
//            return nil
//        }
//
//        let decodedString = String(data: decodedData, encoding: .utf8)
//        print("Decoded Payload: \(decodedString ?? "Decoding failed")")
//
//        do {
//            let payloadJSON = try JSONSerialization.jsonObject(with: decodedData, options: []) as? [String: Any]
//            let userId = payloadJSON?["id"] as? String
//
//            print("User ID: \(userId ?? "No user ID found")")
//
//            return userId
//        } catch {
//            print("Error decoding token payload: \(error)")
//            return nil
//        }
//    }
