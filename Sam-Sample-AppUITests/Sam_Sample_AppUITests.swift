
//
//  Sam_Sample_AppUITests.swift
//  Sam-Sample-AppUITests
//
//  Created by Samantha Cattani on 2023-09-14.
//

import XCTest
@testable import Sam_Sample_App

class Sam_Sample_AppUITests: XCTestCase {
    
    struct AccessibilityIdentifier {
        static let gameTableCell = "Game Table Cell View"
        static let awayTeamImage = "Away Team Image"
        static let awayTeamName = "Away Team Name"
        static let awayTeamScore = "Away Team Score"
        static let homeTeamImage = "Home Team Image"
        static let homeTeamName = "Home Team Name"
        static let homeTeamScore = "Home Team Score"
        static let gameTime = "Game Time"
        static let countryName = "Country Name"
        static let leagueName = "League Name"
        static let statName = "Stat Name"
        static let statVisualComparison = "Stat Visual Comparison"
        static let awayTeamStatValue = "Away Team Stat Value"
        static let homeTeamStatValue = "Home Team Stat Value"
        static let gameStatCell = "Game Stat Cell"
        static let messageCell = "Message Cell"
    }
    
    override func setUpWithError() throws {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testNormalAppFlow() throws {
        let app = XCUIApplication()
        
        let tablesQuery = app.tables
        var cell = tablesQuery.children(matching: .cell).matching(identifier: "Game Table Cell View")
        
        XCTAssert(tablesQuery.cells[AccessibilityIdentifier.gameTableCell].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.awayTeamName].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.awayTeamScore].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.homeTeamName].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.homeTeamScore].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.gameTime].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.countryName].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.leagueName].exists)
        XCTAssert(cell.images[AccessibilityIdentifier.awayTeamImage].exists)
        XCTAssert(cell.images[AccessibilityIdentifier.homeTeamImage].exists)
        
        cell.element(boundBy: 0).tap()
        
        cell = tablesQuery.children(matching: .cell).matching(identifier: "Game Table Cell View")
        
        XCTAssert(app.navigationBars["Sam_Sample_App.GameDetailPageView"].buttons["Back"].exists)
        XCTAssert(tablesQuery.cells[AccessibilityIdentifier.gameTableCell].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.awayTeamName].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.awayTeamScore].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.homeTeamName].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.homeTeamScore].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.gameTime].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.countryName].exists)
        XCTAssert(cell.staticTexts[AccessibilityIdentifier.leagueName].exists)
        XCTAssert(cell.images[AccessibilityIdentifier.awayTeamImage].exists)
        XCTAssert(cell.images[AccessibilityIdentifier.homeTeamImage].exists)
        
        cell = tablesQuery.children(matching: .cell).matching(identifier: "Game Stat Cell")

        if cell.count > 0 {
            XCTAssert(tablesQuery.cells[AccessibilityIdentifier.gameStatCell].exists)
            XCTAssert(cell.staticTexts[AccessibilityIdentifier.awayTeamStatValue].exists)
            XCTAssert(cell.staticTexts[AccessibilityIdentifier.homeTeamStatValue].exists)
            XCTAssert(cell.staticTexts[AccessibilityIdentifier.statName].exists)
            XCTAssert(cell.progressIndicators[AccessibilityIdentifier.statVisualComparison].exists)
        } else {
            cell = tablesQuery.children(matching: .cell).matching(identifier: "MessageCell")
            XCTAssert(tablesQuery.cells[AccessibilityIdentifier.messageCell].exists)
        }
        
        app.navigationBars["Sam_Sample_App.GameDetailPageView"].buttons["Back"].tap()
        
        cell = tablesQuery.children(matching: .cell).matching(identifier: "Game Table Cell View")
        XCTAssert(tablesQuery.cells[AccessibilityIdentifier.gameTableCell].exists)
    }
}
