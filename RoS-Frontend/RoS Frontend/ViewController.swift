//
//  ViewController.swift
//  RoS Frontend
//
//  Created by Alyssa Zhang on 12/4/20.
//

import UIKit

class NavigationMenuBaseController: UITabBarController {
    var customTabBar: TabNavigationMenu!
    var tabBarHeight: CGFloat = 67.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ithaca" // how to change this to view that user is in?
        navigationController?.navigationBar.barTintColor = UIColor(red: 102/255, green: 204/255, blue: 255/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.loadTabBar()
        getHourly()
    }
    
    func loadTabBar() {
        let tabItems: [TabItem] = [.liked, .weather, .profile]
        self.setupCustomTabBar(tabItems) { (controllers) in self.viewControllers = controllers
        }
        self.selectedIndex = 1 // default our selected index to the first item
    }
    
    func getHourly() {
        OpenWeatherManager.getHourly()
    }
    
    func setupCustomTabBar(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        // hide the tab bar
        tabBar.isHidden = true
        self.customTabBar = TabNavigationMenu(menuItems: menuItems, frame: frame)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.clipsToBounds = true
        self.customTabBar.itemTapped = self.changeTab
        // Add it to the view
        self.view.addSubview(customTabBar)
        // Add positioning constraints to place the nav menu right where the tab bar should be
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight), // Fixed height for nav menu
            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
        for i in 0 ..< menuItems.count {
            controllers.append(menuItems[i].viewController) // we fetch the matching view controller and append here
        }
        self.view.layoutIfNeeded() // important step
        completion(controllers) // setup complete. handoff here
    }
    
    func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
}



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }


}

