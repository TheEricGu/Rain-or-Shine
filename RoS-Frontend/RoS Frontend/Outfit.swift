//
//  Outfit.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import Foundation

struct Outfit: Codable {
    var imageName: String
    var weatherTags: [String]
    var didLike: Bool
}
