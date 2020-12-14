//
//  Weather.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import Foundation

// outermost data
struct WeatherData: Codable {
    let current: Current
    let timezone_offset: Int
    var hourly: [RealHourly]
}

// inside current key
struct Current: Codable {
    let dt: Int
    let temp: Float
    let feels_like: Float
    let uvi: Float
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
    let pop: Float
    let wind_speed: Float
}

func unixToDate(unix: Double) -> Date {
    let date = Date(timeIntervalSince1970: unix)
    return date
}

// OUTFITS DATA

struct WeatherResponse: Codable {
    let success: Bool
    let data: [RealOutfit]
}

struct RealOutfit: Codable {
    let gender: String
    let season: String
    let weather: String
    let temp: String
    let url: String
}
