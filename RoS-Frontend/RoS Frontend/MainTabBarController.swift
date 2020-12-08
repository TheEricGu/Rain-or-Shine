//
//  MainTabBarController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/6/20.
//
import UIKit

class MainTabBarController: UITabBarController {

    var weatherV : WeatherViewController!
    var likedV : LikedViewController!
    var profileV : ProfileViewController!
    
    let padding : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor(red:1.0, green:1.0, blue:1.0, alpha:1.0)
        tabBar.shadowImage = UIImage()
        tabBar.unselectedItemTintColor = UIColor(red: 0.925, green: 0.431, blue: 0.298, alpha: 1)
        tabBar.selectedImageTintColor = UIColor(red: 0.925, green: 0.431, blue: 0.298, alpha: 1)
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        weatherV = WeatherViewController()
        likedV = LikedViewController()
        profileV = ProfileViewController()
        
        let weatherController = createNavContoller(vc: weatherV, selectedImage: UIImage(named: "Cloud icon selected.png")! , unselectedImage: UIImage(named: "Cloud icon.png")!)
        let likedController = createNavContoller(vc: likedV, selectedImage: UIImage(named: "Heart icon selected.png")! , unselectedImage: UIImage(named: "Heart icon.png")!)
        let profileController = createNavContoller(vc: profileV, selectedImage: UIImage(named: "Profile icon selected.png")! , unselectedImage: UIImage(named: "Profile icon.png")!)
        
        viewControllers = [likedController, weatherController, profileController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }
    }
}

extension UITabBarController {
    func createNavContoller(vc : UIViewController, selectedImage: UIImage, unselectedImage: UIImage) -> UINavigationController {
        let viewContoller = vc
        let navController = UINavigationController(rootViewController: viewContoller)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }
}
