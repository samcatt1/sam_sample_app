//
//  MatchesDecodable.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-18.
//

import Foundation

struct Matches: Decodable {
  let response: [Response]
}

struct Response: Decodable {
    let fixture: Fixture
    let league: League
    let teams: Teams
    let goals: Goals
}

struct Fixture: Decodable {
    let id: Int
    let status: Status
}

struct Status: Decodable {
    let long: String
    let elapsed: Int
}

struct League: Decodable {
    let name: String
    let country: String
}

struct Teams: Decodable {
    let home: HomeTeam
    let away: AwayTeam
}

struct HomeTeam: Decodable {
    let name: String
    let logo: String
}

struct AwayTeam: Decodable {
    let name: String
    let logo: String
}

struct Goals: Decodable {
    let home: Int
    let away: Int
}
