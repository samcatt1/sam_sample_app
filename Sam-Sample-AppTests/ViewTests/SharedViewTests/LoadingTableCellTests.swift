//
//  LoadingTableCellTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-21.
//
@testable import Sam_Sample_App
import XCTest

final class LoadingTableCellTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
//       try let cell = LoadingTableCell(
//        style: .default,
//        reuseIdentifier: String(describing: LoadingTableCell.self)
//    )
//        XCTAssertThrowsError(LoadingTableCell(coder: NSCoder())
//        )
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
