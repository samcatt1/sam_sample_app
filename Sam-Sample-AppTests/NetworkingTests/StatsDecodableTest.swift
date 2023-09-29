//
//  StatsDecodableTest.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-21.
//

@testable import Sam_Sample_App
import XCTest

final class StatsDecodableTest: XCTestCase {
    
    func testStatsDecoder() throws {
        let url = Bundle.main.url(forResource: "statsSample", withExtension: "json")
        
        guard let url = url else {
            XCTFail("File does not exist")
            return
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let container = try decoder.decode(Stats.self, from: data)
        
        for i in 0...container.response.count - 1 {
            switch i {
            case 0:
                XCTAssertEqual(container.response[i].team.id, 463)
                XCTAssertEqual(container.response[i].team.name, "Aldosivi")
                XCTAssertEqual(container.response[i].statistics[0].type, "Shots on Goal")
                XCTAssertEqual(container.response[i].statistics[0].value?.val, "3")
                XCTAssertEqual(container.response[i].statistics[1].type, "Fouls")
                XCTAssertEqual(container.response[i].statistics[1].value?.val, "22")
                XCTAssertEqual(container.response[i].statistics[2].type, "Ball Possession")
                XCTAssertEqual(container.response[i].statistics[2].value?.val, "32%")
                break
            case 1:
                XCTAssertEqual(container.response[i].team.id, 442)
                XCTAssertEqual(container.response[i].team.name, "Defensa Y Justicia")
                XCTAssertEqual(container.response[i].statistics[0].type, "Shots on Goal")
                XCTAssertEqual(container.response[i].statistics[0].value?.val, nil)
                XCTAssertEqual(container.response[i].statistics[1].type, "Fouls")
                XCTAssertEqual(container.response[i].statistics[1].value?.val, "10")
                XCTAssertEqual(container.response[i].statistics[2].type, "Ball Possession")
                XCTAssertEqual(container.response[i].statistics[2].value?.val, "68%")
                break
            default:
                break
            }
        }
    }
    
    func testTeamDecoder() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"id\": 2, \"name\": \"Real Madrid\"}".utf8)
        let container = try decoder.decode(Team.self, from: data)
        XCTAssertEqual(container.id, 2)
        XCTAssertEqual(container.name, "Real Madrid")
    }

    func testStaticDecoderWithString() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"type\": \"Passing Accuracy\", \"value\": \"68%\"}".utf8)
        let container = try decoder.decode(Statistic.self, from: data)
        XCTAssertEqual(container.type, "Passing Accuracy")
        XCTAssertEqual(container.value?.val, "68%")
    }
    
    func testStaticDecoderWithInt() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"type\": \"Shots\", \"value\": 5}".utf8)
        let container = try decoder.decode(Statistic.self, from: data)
        XCTAssertEqual(container.type, "Shots")
        XCTAssertEqual(container.value?.val, "5")
    }

    func testStaticDecoderWithNull() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"type\": \"Shots\", \"value\": null}".utf8)
        let container = try decoder.decode(Statistic.self, from: data)
        XCTAssertEqual(container.type, "Shots")
        XCTAssertEqual(container.value?.val, nil)
    }
    
    func testStaticDecoderWithOtherType() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"type\": \"Shots\", \"value\": 567.0}".utf8)
        let container = try decoder.decode(Statistic.self, from: data)
        XCTAssertEqual(container.type, "Shots")
        XCTAssertEqual(container.value?.val, "567")
    }

    func testStaticDecoderWithError() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"type\": \"Shots\", \"value\": {\"other\": 4}}".utf8)
        XCTAssertThrowsError(try decoder.decode(Statistic.self, from: data))
    }

}

