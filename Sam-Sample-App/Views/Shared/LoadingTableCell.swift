//
//  LoadingTableCell.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-21.
//

import Foundation
import UIKit

class LoadingTableCell: UITableViewCell {
    struct Constants {
        static let padding: CGFloat = 15
    }
    
    // set up view element
    lazy var loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.accessibilityIdentifier = "Loading"
        return spinner
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
        contentView.addSubview(loadingSpinner)
        layout()
        loadingSpinner.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    // layout view element with constraints
    func layout() {
        loadingSpinner.leadingAnchor.constraint(
            equalTo: contentView.leadingAnchor,
            constant: Constants.padding
        ).isActive = true
        loadingSpinner.trailingAnchor.constraint(
            equalTo: contentView.trailingAnchor,
            constant: -Constants.padding
        ).isActive = true
        loadingSpinner.topAnchor.constraint(
            equalTo: contentView.topAnchor,
            constant: Constants.padding
        ).isActive = true
        loadingSpinner.bottomAnchor.constraint(
            equalTo: contentView.bottomAnchor,
            constant: -Constants.padding
        ).isActive = true
    }
    
}
