//
//  GameCellViewModel.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-17.
//

import Foundation

class GameCellViewModel {
    var gameTime: String
    var league: String
    var country: String
    var team1Score: String
    var team1Logo: String
    var team2Score: String
    var team2Logo: String
    var team1Name: String
    var team2Name: String
    var didTapCell: () -> Void
    
    init(gameTime: String, league: String, country: String,
         team1Score: String, team1Logo: String, team2Score: String,
         team2Logo: String, team1Name: String, team2Name: String,
         didTapCell: @escaping(() -> Void)) {
        self.gameTime = gameTime
        self.league = league
        self.country = country
        self.team1Score = team1Score
        self.team1Logo = team1Logo
        self.team1Name = team1Name
        self.team2Score = team2Score
        self.team2Logo = team2Logo
        self.team2Name = team2Name
        self.didTapCell = didTapCell
    }
}
