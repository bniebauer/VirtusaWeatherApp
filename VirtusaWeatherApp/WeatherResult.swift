//
//  WeatherResult.swift
//  VirtusaWeatherApp
//
//  Created by Brenton Niebauer on 7/27/21.
//

import Foundation

struct Location: Codable {
    var name: String
    var region: String
    
}

struct Condition: Codable {
    var text: String
    var code: Int
}

struct CurrentCondition: Codable {
    var temp_c: Double
    var temp_f: Double
    var condition: Condition
}

struct WeatherResponse: Codable {
    var error: ErrorResponse?
    var location: Location?
    var current: CurrentCondition?
}

struct ErrorResponse: Codable, Error {
    var code: Int
    var message: String

}
