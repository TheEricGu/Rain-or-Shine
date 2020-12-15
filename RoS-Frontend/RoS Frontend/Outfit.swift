//
//  Outfit.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/5/20.
//

import Foundation
import UIKit

extension UserDefaults {
    open func setStruct<T: Codable>(_ value: T?, forKey defaultName: String){
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }
    
    open func structData<T>(_ type: T.Type, forKey defaultName: String) -> T? where T : Decodable {
        guard let encodedData = data(forKey: defaultName) else {
            return nil
        }
        
        return try! JSONDecoder().decode(type, from: encodedData)
    }
    
    open func setStructArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: defaultName)
    }
    
    open func structArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: defaultName) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}

struct Outfit: Codable, Equatable {
    var imageName: String
    var weatherTags: [String]
    var didLike: Bool
    var userPosted: Bool
    // var image: UIImage!
}

//struct postedOutfit: Codable, Equatable {
//    var imageName: String
//    var weatherTags: [String]
//    var didLike: Bool
//    var userPosted: Bool
//    var image: UIImage!
//}
