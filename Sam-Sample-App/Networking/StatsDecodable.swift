//
//  StatsDecodable.swift
//  Sam-Sample-App
//
//  Created by Samantha Cattani on 2023-09-18.
//

import Foundation

struct Stats: Decodable {
  let response: [ResponseVal]
}

struct ResponseVal: Decodable {
    let team: Team
    let statistics: [Statistic]
}

struct Team: Decodable {
    let id: Int
    let name: String
}

struct Statistic: Decodable {
    let type: String
    let value: StringOrInt?
}

// The value of a stat from the API can come back as a String or an Int
// I have created a custom class to deal with this, where the variable val is set to a string
// that can be displayed to the user
class StringOrInt: Decodable {
    var val = ""
    
    required init(from decoder: Decoder) throws {
        if let int = try? decoder.singleValueContainer().decode(Int.self) {
            val = String(int)
            return
        }
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            val = string
            return
        }
        
        throw Error.couldNotFindStringOrInt
    }
    
    enum Error: Swift.Error {
            case couldNotFindStringOrInt
        }
}
