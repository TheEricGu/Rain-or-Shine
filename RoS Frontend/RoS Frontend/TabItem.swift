//
//  TabItem.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/4/20.
//

import Foundation
import UIKit

enum TabItem: String, CaseIterable {
    case liked = "liked"
    case weather = "weather"
    case profile = "profile"
    
    var viewController: UIViewController {
            switch self {
            case .liked:
                return LikedViewController()
        
            case .weather:
                return WeatherViewController()
                
            case .profile:
                return ProfileViewController()
            }
        }
    
    // these can be your icons
    var icon: UIImage {
        switch self {
        case .liked:
            return UIImage(named: "Heart icon.png")!
        
        case .weather:
            return UIImage(named: "Cloud icon.png")!
            
        case .profile:
            return UIImage(named: "Profile icon.png")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
