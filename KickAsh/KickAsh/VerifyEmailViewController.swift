import UIKit

class VerifyEmailViewController: UIViewController {

    @IBOutlet weak var verificationCodeTextField: UITextField!
    

    @IBAction func verifyButtonTapped(_ sender: UIButton) {
        guard let verificationCode = verificationCodeTextField.text, let userEmail = UserDefaults.standard.string(forKey: "userEmail") else {
                    print("Please enter the verification code.")
                    return
                }

                let verificationData: [String: Any] = [
                    "verificationCode": verificationCode,
                    "email": userEmail
                ]

                let url = URL(string: "https://api-kickash-8fefbb641f24.herokuapp.com/auth/verify-email")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: verificationData, options: [])
                } catch {
                    print("An error occurred.")
                    return
                }

                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    if let error = error {
                        print("Error:", error.localizedDescription)
                        return
                    }

                    guard let data = data else {
                        print("Empty response from server")
                        return
                    }

                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        if let emailVerificationResponse = String(data: data, encoding: .utf8) {
                            DispatchQueue.main.async {
                                print("Success:", emailVerificationResponse)
                                self.performSegue(withIdentifier: "VerifyToLoginSegue", sender: nil)
                            }
                        } else {
                            DispatchQueue.main.async {
                                print("Error: Invalid response format.")
                            }
                        }
                    } else {
                        if let emailVerificationResponse = String(data: data, encoding: .utf8) {
                            DispatchQueue.main.async {
                                print("Error:", emailVerificationResponse)
                            }
                        } else {
                            DispatchQueue.main.async {
                                print("Error: Email verification failed.")
                            }
                        }
                    }
                }
        task.resume()
    }
}
