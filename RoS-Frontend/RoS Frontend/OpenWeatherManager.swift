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
    
    static func getHourly() {
        // completion: @escaping ([RealHourly]) -> Void) {
        // ^ should replace empty parameters
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let convertedString : String! = String(data: data, encoding: String.Encoding.utf8)
                print(convertedString)
//                let jsonDecoder = JSONDecoder()
//                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
//                if let coursesData = try? jsonDecoder.decode(Response<CourseDataResponse>.self, from: data) {
//                    let classes = coursesData.data.courses
//                    completion(classes)
//                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
