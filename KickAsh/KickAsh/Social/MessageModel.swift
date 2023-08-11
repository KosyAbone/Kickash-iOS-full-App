
import Foundation

class MessageModel: Decodable {
    //More of a simple user name at this stage
    let userId: String
    let message: String
    let messageTimestamp: String
    
    init(userId: String, message: String, messageTimestamp: String) {
        self.userId = userId
        self.message = message
        self.messageTimestamp = messageTimestamp
    }
}

class PostParamModel: Codable {
    let userId: String
    let message: String
    
    init(userId: String, message: String) {
        self.userId = userId
        self.message = message
    }
}

class MessageApiGetHandler: Decodable {
    let error: String?
    let messages: [MessageModel]?
}

class DatetimeProcessor {
    let dateObj: Date
    let dateString: String
    let dateFormatter = DateFormatter()
    
    init(date: Date) {
        self.dateObj = date
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        self.dateString = dateFormatter.string(from: date)
    }
    
    //Only recognizes "YYYY-MM-DDTHH:mm:ssZ"
    init?(dateString: String) {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            dateObj = date
            self.dateString = dateString
        } else {
            return nil
        }
    }
}

class MessageApiPostHandler: Decodable {
    let error: String?
    let userId: String?
    let message: String?
    let messageTimestamp: String?
}
