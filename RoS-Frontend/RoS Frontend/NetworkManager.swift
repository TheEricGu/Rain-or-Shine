//
//  OpenWeatherManager.swift
//  RoS Frontend
//
//  Created by Sean Yu on 8/20/20.
//  Copyright © 2020 Sean Yu. All rights reserved.
//

import Alamofire
import Foundation

class OpenWeatherManager {

    private static let endpoint = "https://api.openweathermap.org/data/2.5/onecall?lat=42.440632&lon=-76.496613&exclude=minutely,daily,alerts&units=imperial&appid=31bdcbb61617fe23262f9f4d8cec3e09"
    
    static func getCurrent(completion: @escaping (Current) -> Void) {
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let OWData = try? jsonDecoder.decode(WeatherData.self, from: data) {
                    let currentData = OWData.current
                    completion(currentData)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getHourly(completion: @escaping ([RealHourly]) -> Void) {
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
//                let convertedString : String! = String(data: data, encoding: String.Encoding.utf8)
//                print(convertedString)
                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let OWData = try? jsonDecoder.decode(WeatherData.self, from: data) {
                    let hourlyData = OWData.hourly
                    completion(hourlyData)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func getData(completion: @escaping (WeatherData) -> Void) {
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
//                let convertedString : String! = String(data: data, encoding: String.Encoding.utf8)
//                print(convertedString)
                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                if let OWData = try? jsonDecoder.decode(WeatherData.self, from: data) {
                    let data = OWData
                    completion(data)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}


class OutfitsManager {

    private static let header = "https://cornell-rain-or-shine.herokuapp.com/api"
    
    static func getWeatherOutfits(gender: String, season: String, weather: String, temperatureWord: String, completion: @escaping ([RealOutfit]) -> Void) {
        // "\(header)/\(gender)/\(season)/\(weather)/\(temperatureWord)/"
        let endpoint = header + "/outfits/"
        print(endpoint)
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let convertedString : String! = String(data: data, encoding: String.Encoding.utf8)
                print(convertedString!)
                let jsonDecoder = JSONDecoder()
                if let weatherOutfitsData = try? jsonDecoder.decode(WeatherResponse.self, from: data) {
                    let weatherOutfitsList = weatherOutfitsData.data
                    completion(weatherOutfitsList)
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
