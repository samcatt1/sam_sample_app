////
////  ErrorTableCellViewTests.swift
////  Sam-Sample-AppTests
////
////  Created by Samantha Cattani on 2023-09-24.
////
//
//@testable import Sam_Sample_App
//import XCTest
//
//final class ErrorTableCellViewTests: XCTestCase {
//    func testInit() throws {
//        let cell = ErrorTableCell(
//            style: .default,
//            reuseIdentifier: String(describing: ErrorTableCell.self)
//        )
//
//        XCTAssertTrue(cell.selectionStyle == .none)
//        XCTAssertTrue(cell.contentView.subviews.contains(cell.errorMessage))
//        XCTAssertTrue(cell.errorMessage.text == "We are having issues. Please try again later.")
//    }
//
//    func testRequiredInit() throws {
//        let coder = NSCoder()
//        let cell = ErrorTableCell(coder: coder)
//
//        XCTAssertNil(cell)
//    }
//
//    func testLayout() throws {
//        let cell = ErrorTableCell(
//            style: .default,
//            reuseIdentifier: String(describing: ErrorTableCell.self)
//        )
//
//        cell.layout()
//
//        let contentViewConstraints = cell.contentView.constraints
//
//
//        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
//            return constraint.firstItem as? UILabel == cell.errorMessage &&
//            constraint.firstAnchor == cell.errorMessage.leadingAnchor &&
//            constraint.relation == .equal &&
//            constraint.multiplier == 1.0 &&
//            constraint.constant == ErrorTableCell.Constants.padding &&
//            constraint.isActive == true
//        }))
//        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
//            return constraint.firstItem as? UILabel == cell.errorMessage &&
//            constraint.firstAnchor == cell.errorMessage.trailingAnchor &&
//            constraint.relation == .equal &&
//            constraint.multiplier == 1.0 &&
//            constraint.constant == -ErrorTableCell.Constants.padding &&
//            constraint.isActive == true
//        }))
//        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
//            return constraint.firstItem as? UILabel == cell.errorMessage &&
//            constraint.firstAnchor == cell.errorMessage.topAnchor &&
//            constraint.relation == .equal &&
//            constraint.multiplier == 1.0 &&
//            constraint.constant == ErrorTableCell.Constants.padding &&
//            constraint.isActive == true
//        }))
//        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
//            return constraint.firstItem as? UILabel == cell.errorMessage &&
//            constraint.firstAnchor == cell.errorMessage.bottomAnchor &&
//            constraint.relation == .equal &&
//            constraint.multiplier == 1.0 &&
//            constraint.constant == -ErrorTableCell.Constants.padding &&
//            constraint.isActive == true
//        }))
//    }
//}
//
