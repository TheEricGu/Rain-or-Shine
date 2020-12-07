//
//  Weather.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import Foundation

// outermost data
struct Data: Codable {
    let current: Current
    var hourly: [RealHourly]
}

// inside current key
struct Current: Codable {
    let dt: Int
    let temp: Float
    let feels_like: Float
    let uvi: Int
    let clouds: Int
    let wind_speed: Float
    let weather: [Weather]
}

// for all nested weather records
struct Weather: Codable {
    let main: String
    let description: String
    let icon: String
}

// for one singular hourly entry under hourly key
struct RealHourly: Codable {
    let dt: Int
    let temp: Float
    let weather: [Weather]
}

//
// hard-coded hourly
struct Hourly: Codable {
    var time: String
    var imageName: String
    var degrees: String
}
