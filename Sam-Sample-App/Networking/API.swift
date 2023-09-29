//
//  API.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-18.
//

import Foundation

class API {
    func getDataFromInfoPlist(fieldName: String) -> String? {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            let infoListValue = NSDictionary(contentsOfFile: path)
            
            if let field = infoListValue?[fieldName] as? String {
                return field
            }
        }
        
        return nil
    }
    
    func setUpRequest(url: String) -> URLRequest? {
        guard let rapidAPIKey = getDataFromInfoPlist(fieldName: "RapidAPIKey"),
              let rapidAPIHost = getDataFromInfoPlist(fieldName: "RapidAPIHost"),
              let url = NSURL(string: url) as? URL else {
            return nil
        }
        
        let headers = [
            "X-RapidAPI-Key": rapidAPIKey,
            "X-RapidAPI-Host": rapidAPIHost
        ]
        
        var request = URLRequest(url: url,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    // method to get all games currently being played
    // this method will get the data from the API and then decode it using the Maches Decodable
    // it will then set all the models for the matches currently being played (each match has its own model)
    // it will then run finished
    func getMatches(buttonAction: @escaping (Int, GameCellViewModel) -> Void,
                           finished: @escaping ([GameCellViewModel], Bool) -> Void) {
        var matchModels: [GameCellViewModel] = []
        
        let request = setUpRequest(url: "https://api-football-v1.p.rapidapi.com/v3/fixtures?live=all")
        
        guard let req = request else {
            finished(matchModels, true)
            return
        }
        
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                finished(matchModels, true)
                return
            }

            guard let data = data else { return }
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(Matches.self, from: data) {
                for match in jsonData.response {
                    matchModels.append(
                        GameCellViewModel(matchId: match.fixture.id,
                                          gameTime: String(match.fixture.status.elapsed),
                                          league: match.league.name,
                                          country: match.league.country,
                                          team1Score: String(match.goals.away),
                                          team1Logo: match.teams.away.logo,
                                          team2Score: String(match.goals.home),
                                          team2Logo: match.teams.home.logo,
                                          team1Name: match.teams.away.name,
                                          team2Name: match.teams.home.name,
                                          didTapCell: buttonAction))
                }
            }
            finished(matchModels, false)
        }.resume()
    }
    
    // method to get the stats of a specific match
    // this method will get the data from the API and then decode it using the Stats Decodable
    // it will then set all the stats models for the selected match (each stat has its own model)
    // it will then run finished
    func getMatchDetails(fixtureId: Int, finished: @escaping ([GameDetailStatModel], Bool) -> Void) {
        var statModels: [GameDetailStatModel] = []
        
        let request = setUpRequest(url: "https://api-football-v1.p.rapidapi.com/v3/fixtures/statistics?fixture=\(fixtureId)")
        
        guard let req = request else {
            finished(statModels, true)
            return
        }

        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if error != nil {
                finished(statModels, true)
                return
            }

            guard let data = data else { return }
            let decoder = JSONDecoder()
            if let jsonData = try? decoder.decode(Stats.self, from: data) {
                if jsonData.response.count > 0 {
                    let stats = jsonData.response[0].statistics
                    for i in 0...stats.count - 1 {
                        statModels.append(
                            GameDetailStatModel(statName: stats[i].type,
                                                team1Stat: stats[i].value?.val ?? "0",
                                                team2Stat: jsonData.response[1].statistics[i].value?.val ?? "0",
                                                isPercentage: stats[i].value?.val.contains("%") ?? false))
                    }
                }
            }

            finished(statModels, false)
        }.resume()
    }
    
}
