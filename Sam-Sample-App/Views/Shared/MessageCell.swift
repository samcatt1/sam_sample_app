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
    
    lazy var noStatsAvailableLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.text = "There are no statistics available for this match"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(noStatsAvailableLabel)
        layout()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func layout() {
        noStatsAvailableLabel.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: Constants.padding
        ).isActive = true
        noStatsAvailableLabel.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.padding
        ).isActive = true
        noStatsAvailableLabel.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.padding
        ).isActive = true
        noStatsAvailableLabel.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.padding
        ).isActive = true
    }
    
}
