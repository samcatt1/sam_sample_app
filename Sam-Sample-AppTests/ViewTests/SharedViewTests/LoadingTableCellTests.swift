//
//  LoadingTableCellTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-21.
//
@testable import Sam_Sample_App
import XCTest

final class LoadingTableCellTests: XCTestCase {
    
    func testInit() throws {
        let cell = LoadingTableCell(
            style: .default,
            reuseIdentifier: String(describing: LoadingTableCell.self)
        )
        
        XCTAssertTrue(cell.selectionStyle == .none)
        XCTAssertTrue(cell.contentView.subviews.contains(cell.loadingSpinner))
        XCTAssertTrue(cell.loadingSpinner.isAnimating)
    }
    
    func testRequiredInit() throws {
        let coder = NSCoder()
        let cell = LoadingTableCell(coder: coder)
        
        XCTAssertNil(cell)
    }

    func testLayout() throws {
        let cell = LoadingTableCell(
            style: .default,
            reuseIdentifier: String(describing: LoadingTableCell.self)
        )
        
        cell.layout()
        
        let contentViewConstraints = cell.contentView.constraints
        
        
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UIActivityIndicatorView == cell.loadingSpinner &&
            constraint.firstAnchor == cell.loadingSpinner.leadingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == LoadingTableCell.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UIActivityIndicatorView == cell.loadingSpinner &&
            constraint.firstAnchor == cell.loadingSpinner.trailingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -LoadingTableCell.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UIActivityIndicatorView == cell.loadingSpinner &&
            constraint.firstAnchor == cell.loadingSpinner.topAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == LoadingTableCell.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UIActivityIndicatorView == cell.loadingSpinner &&
            constraint.firstAnchor == cell.loadingSpinner.bottomAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -LoadingTableCell.Constants.padding &&
            constraint.isActive == true
        }))
    }
}
