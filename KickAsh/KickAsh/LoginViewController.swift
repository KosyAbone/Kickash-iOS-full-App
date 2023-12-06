import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    static var shared: LoginViewController?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        LoginViewController.shared = self
    }
    
    func ClearLoginTextFields()
    {
        usernameTextField.text = ""
        passwordTextField.text = ""
        usernameTextField.becomeFirstResponder()
    }    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
                    print("Some fields are blank, Please fill in all fields.")
                    return
                }

        if(username == "test" && password == "test") {
              let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let goal = UserDefaults.standard.string(forKey: QuestionnaireDataKey.question8 + username)
            if goal != nil{
                let newViewController = storyBoard.instantiateViewController(withIdentifier:"questionair")
                newViewController.modalPresentationStyle = .fullScreen
                newViewController.isModalInPresentation = true
                self.present(newViewController, animated: true, completion: nil)
            }
            else {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier:"tabController")
                newViewController.modalPresentationStyle = .fullScreen
                newViewController.isModalInPresentation = true
                self.present(newViewController, animated: true, completion: nil)
            }
        }
        
        
        
                let loginData: [String: Any] = [
                    "username": username,
                    "password": password
                ]

                let url = URL(string: "https://api-kickash-8fefbb641f24.herokuapp.com/auth/login")!
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: loginData, options: [])
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

                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let token = json["token"] as? String,
                                let userId = json["userId"] as? String {
                            // Save the token for future use
                            UserDefaults.standard.set(token, forKey: "AuthToken")
                            UserDefaults.standard.set(username, forKey: "Username")
                            UserDefaults.standard.set(userId, forKey: "UserId")
                            
                            
                          //  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                           // let newViewController = storyBoard.instantiateViewController(withIdentifier:"questionair")
                           // self.present(newViewController, animated: true, completion: nil)
                            
                            
                            DispatchQueue.main.async {
                                let completed = UserDefaults.standard.bool(forKey: "QuestionnaireCompleted-" + username)
                                //print("Goal Set!!!", completed)
                                if !completed{
                                    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let newViewController = storyBoard.instantiateViewController(withIdentifier:"questionair")
                                    newViewController.modalPresentationStyle = .fullScreen
                                    newViewController.isModalInPresentation = true
                                    self.present(newViewController, animated: true, completion: nil)
                                    
                                    UserDefaults.standard.set(true, forKey: "QuestionnaireCompleted-" + username)
                              }
                              else {
                                  let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                                  let newViewController = storyBoard.instantiateViewController(withIdentifier:"tabController")
                                  newViewController.modalPresentationStyle = .fullScreen
                                  newViewController.isModalInPresentation = true
                                  self.present(newViewController, animated: true, completion: nil)
                              }
                            }
                        } else {
                            DispatchQueue.main.async {
                                print("Invalid Login Details.")
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            print("Invalid response format. \(error.localizedDescription)")
                        }
                    }
                }
        
            task.resume()
        }
    
    @IBAction func RegisterButton_Pressed(_ sender: UIButton)
    {
        performSegue(withIdentifier: "RegisterSegue", sender: nil)
    }
    
    
    
}


