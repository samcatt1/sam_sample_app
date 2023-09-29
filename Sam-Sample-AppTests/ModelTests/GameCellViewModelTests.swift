//
//  GameCellViewModelTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-21.
//

@testable import Sam_Sample_App
import XCTest

final class GameCellViewModelTests: XCTestCase {
    
    func testDidTapCell(testInt: Int, testModel: GameCellViewModel) { }

    func testInit() throws {
        let model = GameCellViewModel(matchId: 1,
                                      gameTime: "45",
                                      league: "Premier League",
                                      country: "England",
                                      team1Score: "1",
                                      team1Logo: "http://www.test_logo_1.com",
                                      team2Score: "2",
                                      team2Logo: "http://www.test_logo_2.com",
                                      team1Name: "Arsenal",
                                      team2Name: "Tottenham",
                                      didTapCell: testDidTapCell)
        
        XCTAssertEqual(model.matchId, 1)
        XCTAssertEqual(model.gameTime, "45")
        XCTAssertEqual(model.league, "Premier League")
        XCTAssertEqual(model.country, "England")
        XCTAssertEqual(model.team1Score, "1")
        XCTAssertEqual(model.team1Logo, "http://www.test_logo_1.com")
        XCTAssertEqual(model.team2Score, "2")
        XCTAssertEqual(model.team2Logo, "http://www.test_logo_2.com")
        XCTAssertEqual(model.team1Name, "Arsenal")
        XCTAssertEqual(model.team2Name, "Tottenham")
        XCTAssertNoThrow(model.didTapCell(1, model))
    }
}
