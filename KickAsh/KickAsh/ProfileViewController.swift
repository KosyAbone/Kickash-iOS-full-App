//
//  ProfileViewController.swift
//  KickAsh
//
//  Created by Ilham Sheikh on 2023-08-11.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logout(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier:"login")
        newViewController.modalPresentationStyle = .fullScreen
        newViewController.isModalInPresentation = true
        self.present(newViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
