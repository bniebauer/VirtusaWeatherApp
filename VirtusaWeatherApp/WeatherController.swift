//
//  WeatherController.swift
//  VirtusaWeatherApp
//
//  Created by Brenton Niebauer on 7/27/21.
//

import Foundation

class WeatherController {
    static let shared = WeatherController()
    let urlString: String = "http://api.weatherapi.com/v1/current.json"
    let apiKey: String = "08ee85dd3bb64105bec195503212906"
    
    func fetchWeatherFor(zip: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        var urlComponents = URLComponents(string: urlString)!
        urlComponents.queryItems = [URLQueryItem(name: "key", value: apiKey), URLQueryItem(name: "q", value: zip)]
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { data, res, error in
            if let data = data {
                print(String(data: data, encoding: .utf8)!)
                do {
                    let jsonDecoder = JSONDecoder()
                    let decoded = try jsonDecoder.decode(WeatherResponse.self, from: data)
                    if let resError = decoded.error {
                        throw resError
                    }
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
