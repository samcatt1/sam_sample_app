//
//  MatchesDecodableTests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-21.
//

@testable import Sam_Sample_App
import XCTest

final class MatchesDecodableTests: XCTestCase {
    
    func testMatchesDecoder() throws {
        let url = Bundle.main.url(forResource: "gamesSample", withExtension: "json")
        
        guard let url = url else {
            XCTFail("File does not exist")
            return
        }
        
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let container = try decoder.decode(Matches.self, from: data)
        
        for i in 0...container.response.count - 1 {
            switch i {
            case 0:
                XCTAssertEqual(container.response[i].fixture.id, 1053407)
                XCTAssertEqual(container.response[i].fixture.status.elapsed, 19)
                XCTAssertEqual(container.response[i].fixture.status.long, "First Half")
                XCTAssertEqual(container.response[i].league.name, "Regionalliga - Mitte")
                XCTAssertEqual(container.response[i].league.country, "Austria")
                XCTAssertEqual(container.response[i].teams.home.name, "Gurten")
                XCTAssertEqual(container.response[i].teams.home.logo, "https://media-4.api-sports.io/football/teams/4942.png")
                XCTAssertEqual(container.response[i].teams.away.name, "LASK Juniors")
                XCTAssertEqual(container.response[i].teams.away.logo, "https://media-4.api-sports.io/football/teams/11225.png")
                XCTAssertEqual(container.response[i].goals.home, 0)
                XCTAssertEqual(container.response[i].goals.away, 0)
                break
            case 1:
                XCTAssertEqual(container.response[i].fixture.id, 1088402)
                XCTAssertEqual(container.response[i].fixture.status.elapsed, 45)
                XCTAssertEqual(container.response[i].fixture.status.long, "First Half")
                XCTAssertEqual(container.response[i].league.name, "Segunda División RFEF - Group 5")
                XCTAssertEqual(container.response[i].league.country, "Spain")
                XCTAssertEqual(container.response[i].teams.home.name, "Guadalajara")
                XCTAssertEqual(container.response[i].teams.home.logo, "https://media-4.api-sports.io/football/teams/9900.png")
                XCTAssertEqual(container.response[i].teams.away.name, "SS Reyes")
                XCTAssertEqual(container.response[i].teams.away.logo, "https://media-4.api-sports.io/football/teams/9412.png")
                XCTAssertEqual(container.response[i].goals.home, 1)
                XCTAssertEqual(container.response[i].goals.away, 1)
                break
            case 2:
                XCTAssertEqual(container.response[i].fixture.id, 1089019)
                XCTAssertEqual(container.response[i].fixture.status.elapsed, 18)
                XCTAssertEqual(container.response[i].fixture.status.long, "First Half")
                XCTAssertEqual(container.response[i].league.name, "Oberliga - Bayern Nord")
                XCTAssertEqual(container.response[i].league.country, "Germany")
                XCTAssertEqual(container.response[i].teams.home.name, "Donaustauf")
                XCTAssertEqual(container.response[i].teams.home.logo, "https://media-4.api-sports.io/football/teams/17030.png")
                XCTAssertEqual(container.response[i].teams.away.name, "Ammerthal")
                XCTAssertEqual(container.response[i].teams.away.logo, "https://media-4.api-sports.io/football/teams/14619.png")
                XCTAssertEqual(container.response[i].goals.home, 0)
                XCTAssertEqual(container.response[i].goals.away, 0)
                break
            default:
                break
            }
        }
    }
    
    func testGoalsDecoder() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"home\": 2, \"away\": 3}".utf8)
        let container = try decoder.decode(Goals.self, from: data)
        XCTAssertEqual(container.home, 2)
        XCTAssertEqual(container.away, 3)
    }
    
    func testAwayTeamDecoder() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"name\": \"test_name\", \"logo\": \"test_logo\"}".utf8)
        let container = try decoder.decode(AwayTeam.self, from: data)
        XCTAssertEqual(container.name, "test_name")
        XCTAssertEqual(container.logo, "test_logo")
    }
    
    func testHomeTeamDecoder() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"name\": \"test_name\", \"logo\": \"test_logo\"}".utf8)
        let container = try decoder.decode(HomeTeam.self, from: data)
        XCTAssertEqual(container.name, "test_name")
        XCTAssertEqual(container.logo, "test_logo")
    }
    
    func testTeamsDecoder() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"home\": {\"name\": \"test_name_1\", \"logo\": \"test_logo_1\"}, \"away\": {\"name\": \"test_name_2\", \"logo\": \"test_logo_2\"}}".utf8)
        let container = try decoder.decode(Teams.self, from: data)
        XCTAssertEqual(container.home.name, "test_name_1")
        XCTAssertEqual(container.home.logo, "test_logo_1")
        XCTAssertEqual(container.away.name, "test_name_2")
        XCTAssertEqual(container.away.logo, "test_logo_2")
    }
    
    func testLeagueDecoder() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"name\": \"test_name\", \"country\": \"test_country\"}".utf8)
        let container = try decoder.decode(League.self, from: data)
        XCTAssertEqual(container.name, "test_name")
        XCTAssertEqual(container.country, "test_country")
    }
    
    func testStatusDecoder() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"long\": \"Halftime\", \"elapsed\": 45}".utf8)
        let container = try decoder.decode(Status.self, from: data)
        XCTAssertEqual(container.long, "Halftime")
        XCTAssertEqual(container.elapsed, 45)
    }
    
    func testFixtureDecoder() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"status\": {\"long\": \"Halftime\", \"elapsed\": 45}, \"id\": 2}".utf8)
        let container = try decoder.decode(Fixture.self, from: data)
        XCTAssertEqual(container.status.long, "Halftime")
        XCTAssertEqual(container.status.elapsed, 45)
        XCTAssertEqual(container.id, 2)
    }
    
    func testResponseDecoder() throws {
        let decoder = JSONDecoder()
        let data = Data("{\"fixture\": {\"status\": {\"long\": \"Halftime\", \"elapsed\": 45}, \"id\": 3946}, \"league\": {\"name\": \"Premier League\", \"country\": \"England\"}, \"teams\": {\"home\": {\"name\": \"Manchester United\", \"logo\": \"http://home_team_logo\"}, \"away\": {\"name\": \"Manchester City\", \"logo\": \"http://away_team_logo\"}}, \"goals\": {\"home\": 2, \"away\": 2}}".utf8)
        
        let container = try decoder.decode(Response.self, from: data)
        
        XCTAssertEqual(container.fixture.id, 3946)
        XCTAssertEqual(container.fixture.status.elapsed, 45)
        XCTAssertEqual(container.fixture.status.long, "Halftime")
        XCTAssertEqual(container.league.name, "Premier League")
        XCTAssertEqual(container.league.country, "England")
        XCTAssertEqual(container.teams.home.name, "Manchester United")
        XCTAssertEqual(container.teams.home.logo, "http://home_team_logo")
        XCTAssertEqual(container.teams.away.name, "Manchester City")
        XCTAssertEqual(container.teams.away.logo, "http://away_team_logo")
        XCTAssertEqual(container.goals.home, 2)
        XCTAssertEqual(container.goals.away, 2)
    }
}
