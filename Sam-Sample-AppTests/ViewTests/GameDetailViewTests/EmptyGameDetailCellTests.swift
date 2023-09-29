//
//  EmptyGameDetailCellTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-24.
//

@testable import Sam_Sample_App
import XCTest

final class EmptyGameDetailCellTests: XCTestCase {
    func testInit() throws {
        let cell = MessageCell(
            style: .default,
            reuseIdentifier: String(describing: MessageCell.self)
        )
        
        XCTAssertTrue(cell.selectionStyle == .none)
        XCTAssertTrue(cell.contentView.subviews.contains(cell.messageText))
    }
    
    func testRequiredInit() throws {
        let coder = NSCoder()
        let cell = MessageCell(coder: coder)
        
        XCTAssertNil(cell)
    }

    func testLayout() throws {
        let cell = MessageCell(
            style: .default,
            reuseIdentifier: String(describing: MessageCell.self)
        )
        
        cell.layout()
        
        let contentViewConstraints = cell.contentView.constraints
        
        
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.messageText &&
            constraint.firstAnchor == cell.messageText.leadingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == MessageCell.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.messageText &&
            constraint.firstAnchor == cell.messageText.trailingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -MessageCell.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.messageText &&
            constraint.firstAnchor == cell.messageText.topAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == MessageCell.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.messageText &&
            constraint.firstAnchor == cell.messageText.bottomAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -MessageCell.Constants.padding &&
            constraint.isActive == true
        }))
    }
    
    func testConfigure() throws {
        let cell = MessageCell(
            style: .default,
            reuseIdentifier: String(describing: MessageCell.self)
        )
        
        let message = "Test message"
        cell.configure(message: message)
        
        XCTAssertTrue(message == cell.messageText.text)
    }
}

