//
//  GameDetailStatModelTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-21.
//

@testable import Sam_Sample_App
import XCTest

final class GameDetailStatModelTests: XCTestCase {
    
    func testInitWithNoPercentage() throws {
        let model = GameDetailStatModel(statName: "Test No Percent",
                                        team1Stat: "1",
                                        team2Stat: "2",
                                        isPercentage: false
        )
        
        XCTAssertTrue(model.statName == "Test No Percent")
        XCTAssertTrue(model.team1Stat == "1")
        XCTAssertTrue(model.team2Stat == "2")
        XCTAssertFalse(model.isPercentage)
    }

    func testInitWithPercentage() throws {
        let model = GameDetailStatModel(statName: "Test With Percent",
                                        team1Stat: "40%",
                                        team2Stat: "60%",
                                        isPercentage: true
        )
        
        XCTAssertTrue(model.statName == "Test With Percent")
        XCTAssertTrue(model.team1Stat == "40%")
        XCTAssertTrue(model.team2Stat == "60%")
        XCTAssertTrue(model.isPercentage)
    }

}
