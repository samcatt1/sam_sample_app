//
//  MatchesDecodable.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-18.
//

import Foundation

struct Matches: Codable {
  let response: [Response]
}

struct Response: Codable {
    let fixture: Fixture
    let league: League
    let teams: Teams
    let goals: Goals
}

struct Fixture: Codable {
    let id: Int
    let status: Status
}

struct Status: Codable {
    let long: String
    let elapsed: Int
}

struct League: Codable {
    let name: String
    let country: String
}

struct Teams: Codable {
    let home: HomeTeam
    let away: AwayTeam
}

struct HomeTeam: Codable {
    let name: String
    let logo: String
}

struct AwayTeam: Codable {
    let name: String
    let logo: String
}

struct Goals: Codable {
    let home: Int
    let away: Int
}
