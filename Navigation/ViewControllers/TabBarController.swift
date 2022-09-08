//
//  TabBarController.swift
//  Navigation
//
//  Created by Vladislav Green on 8/23/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let feedViewController = UINavigationController (rootViewController: FeedViewController())
        let logInViewController = UINavigationController (rootViewController: LogInViewController())
        
        self.viewControllers = [feedViewController, logInViewController]
        
        let item1 = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        let item2 = UITabBarItem(title: "Profile", image:  UIImage(systemName: "person.fill"), tag: 1)

        feedViewController.tabBarItem = item1
        logInViewController.tabBarItem = item2
        
//        UITabBar.appearance().tintColor = UIColor(red: 0/255.0, green: 146/255.0, blue: 0/255.0, alpha: 1.0)
        UITabBar.appearance().backgroundColor = .white
    }
    
}

