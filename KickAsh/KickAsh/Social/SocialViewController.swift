
import Foundation
import UIKit


class SocialViewController: UIViewController {
    
    let API_URL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func updateDataFromAPI() {
        //Simple GET/JSON decoding process with error catching
        guard let url = URL(string: API_URL) else {
            Utility.showAlert(title: "Error", message: "Unexpected error", originView: self)
            Utility.debugLog("Invalid URL setup")
            return
        }
        
        
        MessageApiHandler.executeAPIRequest(url: url){ (result: Result<MessageApiGetHandler, Error>) in
            switch result {
            case .success(let response):
                guard let messages = response.messages else {
                    Utility.showAlert(title: "Error", message: "Unexpected error", originView: self)
                    Utility.debugLog("Cannot find valid message in response")
                    return
                }
                
                self.updateUIList(messages: messages)
            case .failure(let error):
                Utility.showAlert(title: "Error", message: "Unexpected error", originView: self)
                Utility.debugLog(error.localizedDescription)
            }
        }
        
    }
    
    func postMessageToAPI(message: String) {
        if (message.isEmpty) {
            return;
        }
        
        guard let url = URL(string: API_URL) else {
            Utility.showAlert(title: "Error", message: "Unexpected error", originView: self)
            Utility.debugLog("Invalid URL setup")
            return
        }
        
        var param: PostParamModel
        var body: Data
        do {
            param = PostParamModel(userId: "Anonymous", message:"")
            body = try JSONEncoder().encode(param)
        } catch {
            let encodingError = error as? EncodingError
            let errorMessage = encodingError?.localizedDescription ?? "UNKNOWN"
            Utility.showAlert(title: "Error", message: "Unexpected error", originView: self)
            Utility.debugLog("Failed to encode message, message: " + errorMessage)
            return
        }
        
        MessageApiHandler.executeAPIRequest(url: url, httpMethod: "POST", requestBody: body){ (result: Result<MessageApiPostHandler, Error>) in
            switch result {
            case .success(let response):
                guard let userId = response.userId,
                      let message = response.message,
                      let messageTimestamp = response.messageTimestamp else {
                    Utility.showAlert(title: "Error", message: "Unexpected error", originView: self)
                    Utility.debugLog("Cannot find valid message in response")
                    return
                }
                
                let responseMessage = MessageModel(userId: userId, message: message, messageTimestamp: messageTimestamp)
                self.appendItem(message: responseMessage)
            case .failure(let error):
                Utility.showAlert(title: "Error", message: "Unexpected error", originView: self)
                Utility.debugLog(error.localizedDescription)
            }
        }
    }
    
    
    func updateUIList(messages: [MessageModel]) {
        //Code to update list from API data
    }
    
    func appendItem(message: MessageModel) {
        //Code to append item
    }
}
