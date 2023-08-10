
import Foundation
import UIKit


class SocialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    var dataUpdateTimer: Timer?
    var initLoadFinished: Bool = false
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialTableViewCell", for: indexPath) as! SocialTableViewCell
        let message = dataArray[indexPath.row]
        cell.configure(message: message)
        return cell
    }
    
    
    let API_URL = "https://byteforce-api.onrender.com/messages"
    @IBOutlet weak var tableView: UITableView!
    var dataArray: [MessageModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 210
        
        
        DispatchQueue.global(qos: .background).async {
            self.updateDataFromAPI() {
                self.initLoadFinished = true
                self.scrollToTableViewBottom()
            }
        }
        
        dataUpdateTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(updateDataFromAPITimerFired), userInfo: nil, repeats: true)

    }
    @objc func updateDataFromAPITimerFired() {
        DispatchQueue.global(qos: .background).async {
            if (self.initLoadFinished) {
                self.updateDataFromAPI() {}
            }
        }
    }
    deinit {
        dataUpdateTimer?.invalidate()
    }
    
    
    func scrollToTableViewBottom() {
        
        DispatchQueue.main.async {
            let lastRowIndex = self.tableView.numberOfRows(inSection: 0) - 1
            let indexPath = IndexPath(row: lastRowIndex, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let object = dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SocialTableViewCell") as! SocialTableViewCell
        cell.configure(message: object)
        cell.layoutIfNeeded()
        let fittingSize = CGSize(width: tableView.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let size = cell.contentView.systemLayoutSizeFitting(fittingSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        return size.height
    }

    func updateDataFromAPI(completion: @escaping () -> Void) {
        //Simple GET/JSON decoding process with error catching
        guard let url = URL(string: API_URL) else {
            self.reportError(logMessage: "Invalid URL setup", displayMessage: "Unexpected error")
            completion()
            return
        }
        
        
        MessageApiHandler.executeAPIRequest(url: url){ (result: Result<MessageApiGetHandler, Error>) in
            switch result {
            case .success(let response):
                guard let messages = response.messages else {
                    self.reportError(logMessage: "Cannot find valid message in response", displayMessage: "Unexpected error")
                    completion()
                    return
                }
                
                
                DispatchQueue.main.async {
                    self.updateUIList(messages: messages)
                    completion()
                }
            case .failure(let error):
                self.reportError(logMessage: error.localizedDescription, displayMessage: "Unexpected error")
                completion()
            }
        }
        
    }
    
    @IBAction func checkEmptyMessage(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            sendButton.isEnabled = true
        } else {
            sendButton.isEnabled = false
        }
    }
    @IBAction func sendMessage(_ sender: UIButton) {
        if (messageField.hasText && messageField.text != nil) {
            postMessageToAPI(message: messageField.text ?? "")
        }
    }
    func postMessageToAPI(message: String) {
        if (message.isEmpty) {
            return;
        }
        
        guard let url = URL(string: API_URL) else {
            self.reportError(logMessage: "Invalid URL setup", displayMessage: "Unexpected error")
            return
        }
        
        var param: PostParamModel
        var body: Data
        do {
            param = PostParamModel(userId: "Anonymous", message:message)
            body = try JSONEncoder().encode(param)
        } catch {
            let encodingError = error as? EncodingError
            let errorMessage = encodingError?.localizedDescription ?? "UNKNOWN"
            self.reportError(logMessage: "Failed to encode message, message: " + errorMessage, displayMessage: "Unexpected error")
            return
        }
        
        MessageApiHandler.executeAPIRequest(url: url, httpMethod: "POST", requestBody: body){ (result: Result<MessageApiPostHandler, Error>) in
            switch result {
            case .success(let response):
                guard let userId = response.userId,
                      let message = response.message,
                      let messageTimestamp = response.messageTimestamp else {
                    self.reportError(logMessage: "Cannot find valid message in response", displayMessage: "Unexpected error")
                    return
                }
                
                
                DispatchQueue.main.async {
                    let responseMessage = MessageModel(userId: userId, message: message, messageTimestamp: messageTimestamp)
                    self.appendItem(message: responseMessage)
                    self.sendButton.isEnabled = true
                    self.messageField.text = ""
                }
            case .failure(let error):
                self.reportError(logMessage: error.localizedDescription, displayMessage: "Unexpected error")
            }
        }
    }
    
    
    func updateUIList(messages: [MessageModel]) {
        dataArray = messages
        dataArray.reverse()
        tableView.reloadData()
    }
    
    func appendItem(message: MessageModel) {
        dataArray.append(message)
        
        let indexPath = IndexPath(row: dataArray.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    
    func reportError(logMessage: String, displayMessage: String? = nil) {
        DispatchQueue.main.async {
            if let displayMessage = displayMessage {
                Utility.showAlert(title: "Error", message: displayMessage, originView: self)
            }
            
            Utility.debugLog(logMessage)
        }
    }
}
