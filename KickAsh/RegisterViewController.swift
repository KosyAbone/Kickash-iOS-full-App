import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        guard let firstName = firstNameTextField.text, let lastName = lastNameTextField.text, let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmPasswordTextField.text else {
            print("Please fill in all fields.")
            return
        }

        // Check if password and confirm password match
        guard password == confirmPassword else {
            print("Passwords do not match.")
            return
        }

        let registrationData: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "username": username,
            "email": email,
            "password": password,
        ]

        let url = URL(string: "https://api-kickash-8fefbb641f24.herokuapp.com/auth/register")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: registrationData, options: [])
        } catch {
            print("An error occurred.")
            return
        }

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    print("Error:", error.localizedDescription)
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    print("Empty response from server")
                }
                return
            }

            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let registrationResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = registrationResponse["message"] as? String {
                    DispatchQueue.main.async {
                        print("Success:", message)
                        UserDefaults.standard.set(email, forKey: "userEmail")
                        self.performSegue(withIdentifier: "VerifySegue", sender: nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Error: Invalid response format.")
                    }
                }
            } else {
                if let registrationResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let message = registrationResponse["message"] as? String {
                    DispatchQueue.main.async {
                        print("Error:", message)
                    }
                } else {
                    DispatchQueue.main.async {
                        print("Error: Registration failed.")
                    }
                }
            }
        }
        task.resume()
    }
    
    @IBAction func CancelButton_Pressed(_ sender: UIButton)
    {
        // Clear the username and password in the LoginViewController
        LoginViewController.shared?.ClearLoginTextFields()
        dismiss(animated: true, completion: nil)
    }
}

