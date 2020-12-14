//
//  Global.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/14/20.
//

import Foundation

// user defaults
let defaults = UserDefaults.standard


let appGroup = "group.com.alyssazhang.RoS-Frontend"
let genderKey = "gender"
//let likedOutfits: [Outfit] = []
let likedOutfitsKey = "likedOutfits"

struct Global {
    
    // gender
    static func getGender() -> String {
        return UserDefaults(suiteName: appGroup)?.object(forKey: genderKey) as! String
    }
    
    static func setGender(gender: String) {
        UserDefaults(suiteName: appGroup)?.set(gender, forKey: genderKey)
    }
    
    // liked outfits
    static func getLikedOutfits() -> [Outfit] {
        return UserDefaults(suiteName: appGroup)?.object(forKey: likedOutfitsKey) as! [Outfit]
    }
    
    static func setLikedOutfits(outfit: Outfit){
        UserDefaults(suiteName: appGroup)?.set(outfit, forKey: likedOutfitsKey)
    }
    
}
