//
//  SocialTableViewCell.swift
//  KickAsh
//
//  Created by builder on 10/8/2023.
//

import Foundation
import UIKit
class SocialTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var messageLabel: UILabel!
    func configure(message: MessageModel) {
        textView.text = message.message
        
        
        var dateString = ""
        if let datetime = DatetimeProcessor(dateString: message.messageTimestamp)?.dateObj {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            let formattedDateString = dateFormatter.string(from: datetime)
            dateString = " - " + formattedDateString
        }
        
        
        messageLabel.text = message.userId + dateString
    }
}
