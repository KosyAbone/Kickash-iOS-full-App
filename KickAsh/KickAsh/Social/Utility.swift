
import Foundation
import UIKit

class Utility {
    static func showAlert(title: String, message: String, originView: UIViewController?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        if let presentingVC = originView {
            presentingVC.present(alert, animated: true, completion: nil)
        } else {
            debugLog("Invalid view controller")
        }
    }
    
    static func debugLog(_ message: String) {
        #if DEBUG
        print(message)
        #endif
    }

}
