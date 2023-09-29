//
//  GameDetailStatModel.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-18.
//

import Foundation

class GameDetailStatModel {
    var statName: String
    var team1Stat: String
    var team2Stat: String
    var isPercentage: Bool
    
    init(statName: String, team1Stat: String, team2Stat: String, isPercentage: Bool) {
        self.statName = statName
        self.team1Stat = team1Stat
        self.team2Stat = team2Stat
        self.isPercentage = isPercentage
    }
}
