//
//  MockAPI.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-22.
//

import Foundation
@testable import Sam_Sample_App

class MockAPI: API {
    override func getMatches(buttonAction: @escaping (Int, GameCellViewModel) -> Void, finished: @escaping ([GameCellViewModel], Bool) -> Void) {
        var models: [GameCellViewModel] = []
        
        for i in 0...2 {
            models.append(GameCellViewModel(matchId: i,
                                            gameTime: String(i),
                                            league: "League \(i)",
                                            country: "Country \(i)",
                                            team1Score: String(i),
                                            team1Logo: "Logo Team1 \(i)",
                                            team2Score: String(i),
                                            team2Logo: "Logo Team2 \(i)",
                                            team1Name: "Name Team1 \(i)",
                                            team2Name: "Name Team2 \(i)",
                                            didTapCell: buttonAction)
            )
        }
        
        finished(models, false)
    }
    
    override func getMatchDetails(fixtureId: Int, finished: @escaping ([GameDetailStatModel], Bool) -> Void) {
        var models: [GameDetailStatModel] = []
        
        for i in 0...2 {
            models.append(GameDetailStatModel(statName: "Stat \(i)",
                                              team1Stat: i % 2 == 0 ? "Team1 Stat \(i)" : "Team1 Stat \(i)%",
                                              team2Stat: i % 2 == 0 ? "Team2 Stat \(i)" : "Team2 Stat \(i)%",
                                              isPercentage: i % 2 != 0)
            )
        }
        
        finished(models, false)
    }
}
