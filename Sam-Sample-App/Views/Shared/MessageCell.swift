//
//  EmptyGameDetailCell.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-20.
//

import Foundation
import UIKit

class MessageCell: UITableViewCell {
    struct Constants {
        static let padding: CGFloat = 15
    }
    
    // set up view element
    lazy var messageText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.accessibilityIdentifier = "Message Text"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        accessibilityIdentifier = "Message Cell"
        selectionStyle = .none
        contentView.addSubview(messageText)
        layout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // layout view element with view constraints
    func layout() {
        messageText.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: Constants.padding
        ).isActive = true
        messageText.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.padding
        ).isActive = true
        messageText.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.padding
        ).isActive = true
        messageText.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.padding
        ).isActive = true
    }
    
    // method to configure the message to say custom string
    func configure(message: String) {
        messageText.text = message
    }
    
}
