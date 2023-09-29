//
//  GameDetailCellTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-24.
//

@testable import Sam_Sample_App
import XCTest

final class GameDetailCellTests: XCTestCase {
    
    var cell: GameDetailCellView?
    var modelNonPercentage: GameDetailStatModel?
    var modelPercentage: GameDetailStatModel?
    var modelAllZero: GameDetailStatModel?
    
    override func setUpWithError() throws {
        cell = GameDetailCellView(
            style: .default,
            reuseIdentifier: String(describing: GameDetailCellView.self)
        )
        
        modelNonPercentage = GameDetailStatModel(
            statName: "Shots on Goal",
            team1Stat: "2",
            team2Stat: "3",
            isPercentage: false
        )
        
        modelPercentage = GameDetailStatModel(
            statName: "Passing Accuracy",
            team1Stat: "75%",
            team2Stat: "50%",
            isPercentage: true
        )
        
        modelAllZero = GameDetailStatModel(
            statName: "Shots on Goal",
            team1Stat: "0",
            team2Stat: "0",
            isPercentage: false
        )
    }

    override func tearDownWithError() throws {
        cell = nil
        modelNonPercentage = nil
        modelPercentage = nil
    }
    
    func testInit() throws {
        let cell = GameDetailCellView(
            style: .default,
            reuseIdentifier: String(describing: GameDetailCellView.self)
        )
        
        XCTAssertTrue(cell.selectionStyle == .none)
        XCTAssertTrue(cell.contentView.subviews.contains(cell.statName))
        XCTAssertTrue(cell.contentView.subviews.contains(cell.bar))
        XCTAssertTrue(cell.contentView.subviews.contains(cell.team1Stat))
        XCTAssertTrue(cell.contentView.subviews.contains(cell.team2Stat))
    }
    
    func testRequiredInit() throws {
        let coder = NSCoder()
        let cell = GameDetailCellView(coder: coder)
        
        XCTAssertNil(cell)
    }

    func testLayout() throws {
        guard let cell = cell else {
            XCTFail("Cell was not initialized")
            return
        }
        
        cell.layout()
        
        let contentViewConstraints = cell.contentView.constraints
        
        
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.statName &&
            constraint.firstAnchor == cell.statName.leadingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.statName &&
            constraint.firstAnchor == cell.statName.trailingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.statName &&
            constraint.firstAnchor == cell.statName.topAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == GameDetailCellView.Constants.padding * 2 &&
            constraint.isActive == true
        }))
        
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.team1Stat &&
            constraint.firstAnchor == cell.team1Stat.leadingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.team1Stat &&
            constraint.firstAnchor == cell.team1Stat.bottomAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.team1Stat &&
            constraint.firstAnchor == cell.team1Stat.topAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.team2Stat &&
            constraint.firstAnchor == cell.team2Stat.trailingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.team2Stat &&
            constraint.firstAnchor == cell.team2Stat.bottomAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UILabel == cell.team2Stat &&
            constraint.firstAnchor == cell.team2Stat.topAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UIProgressView == cell.bar &&
            constraint.firstAnchor == cell.bar.leadingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UIProgressView == cell.bar &&
            constraint.firstAnchor == cell.bar.bottomAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UIProgressView == cell.bar &&
            constraint.firstAnchor == cell.bar.topAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
        XCTAssertTrue(contentViewConstraints.contains(where: { constraint -> Bool in
            return constraint.firstItem as? UIProgressView == cell.bar &&
            constraint.firstAnchor == cell.bar.trailingAnchor &&
            constraint.relation == .equal &&
            constraint.multiplier == 1.0 &&
            constraint.constant == -GameDetailCellView.Constants.padding &&
            constraint.isActive == true
        }))
    }
    
    func testConfigurePercentage() throws {
        guard let cell = cell, let model = modelPercentage else {
            XCTFail("Cell was not initialized")
            return
        }
        
        cell.configure(model: model)
        
        XCTAssertTrue(cell.statName.text == model.statName.uppercased())
        XCTAssertTrue(cell.team1Stat.text == "\(model.team1Stat)%")
        XCTAssertTrue(cell.team2Stat.text == "\(model.team2Stat)%")
        XCTAssertTrue(cell.bar.progress == 0.6)
        XCTAssertTrue(cell.bar.trackTintColor == .green)
        XCTAssertTrue(cell.bar.tintColor == .blue)
    }
    
    func testConfigureNonPercentage() throws {
        guard let cell = cell, let model = modelNonPercentage else {
            XCTFail("Cell was not initialized")
            return
        }
        
        cell.configure(model: model)
        
        XCTAssertTrue(cell.statName.text == model.statName.uppercased())
        XCTAssertTrue(cell.team1Stat.text == model.team1Stat)
        XCTAssertTrue(cell.team2Stat.text == model.team2Stat)
        XCTAssertTrue(cell.bar.progress == 0.4)
        XCTAssertTrue(cell.bar.trackTintColor == .green)
        XCTAssertTrue(cell.bar.tintColor == .blue)
    }
    
    func testConfigureAllZeroes() throws {
        guard let cell = cell, let model = modelAllZero else {
            XCTFail("Cell was not initialized")
            return
        }
        
        cell.configure(model: model)
        
        XCTAssertTrue(cell.statName.text == model.statName.uppercased())
        XCTAssertTrue(cell.team1Stat.text == model.team1Stat)
        XCTAssertTrue(cell.team2Stat.text == model.team2Stat)
        XCTAssertTrue(cell.bar.progress == 0.0)
        XCTAssertTrue(cell.bar.trackTintColor == .lightGray)
        XCTAssertTrue(cell.bar.tintColor == .lightGray)
    }
}


