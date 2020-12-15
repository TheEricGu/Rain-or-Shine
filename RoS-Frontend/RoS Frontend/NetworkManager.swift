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

    private static let endpoint1 = "https://api.openweathermap.org/data/2.5/onecall?lat="
    // 42.440632 ithaca lat
    private static let endpoint2 = "&lon="
    // -76.496613 ithaca long
    private static let endpoint3 = "&exclude=minutely,daily,alerts&units=imperial&appid=31bdcbb61617fe23262f9f4d8cec3e09"
    private static let ithacaEndpoint = "https://api.openweathermap.org/data/2.5/onecall?lat=42.440632&lon=-76.496613&exclude=minutely,daily,alerts&units=imperial&appid=31bdcbb61617fe23262f9f4d8cec3e09"
    static func getCurrent(lat: Float, long: Float, completion: @escaping (Current) -> Void) {
        var endpoint = endpoint1 + String(lat) + endpoint2 + String(long) + endpoint3
        if lat == -6969 {
            endpoint = ithacaEndpoint
        }
        print("this is current endpoint " + endpoint)
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
    
    static func getHourly(lat: Float, long: Float, completion: @escaping ([RealHourly]) -> Void) {
        print("this is input latlong " + String(lat) + ", " + String(long))
        var endpoint = endpoint1 + String(lat) + endpoint2 + String(long) + endpoint3
        if lat == -6969 {
            endpoint = ithacaEndpoint
        }
        print("this is current endpoint " + endpoint)
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
    
    static func getData(lat: Float, long: Float, completion: @escaping (WeatherData) -> Void) {
        var endpoint = endpoint1 + String(lat) + endpoint2 + String(long) + endpoint3
        if lat == -6969 {
            endpoint = ithacaEndpoint
        }
        print("this is current endpoint " + endpoint)
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
        print("getweatheroutfits is running")
        print(gender + season + weather + temperatureWord)
        let endpoint = "\(header)/outfits/\(gender)/\(season)/\(weather)/\(temperatureWord)/"
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
    
    static func postOutfit(gender: String, season: String, weather: String, temperatureWord: String, image: UIImage) {
        let endpoint = header + "/outfits/"
//        print(endpoint)
        let compressedImageData : Data! = image.jpegData(compressionQuality: 0.25)
        let imageBase64 : String = compressedImageData.base64EncodedString(options: .lineLength64Characters)
//        print(gender)
//        print(season)
//        print(weather)
//        print(temperatureWord)
        let parameters = [
            "gender" : gender,
            "season" : season,
            "weather" : weather,
            "temp": temperatureWord,
            "image_data": ("data:image/jpeg;base64," + imageBase64)
        ] as Parameters
//        print(parameters)
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .response { request in
                let dataString = NSString(data: request.data!, encoding:String.Encoding.utf8.rawValue)
                    print(dataString)
            }
        }
        
    }
