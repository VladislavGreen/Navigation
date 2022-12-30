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
        
    // код перенесён в SceneDelegate
//        let feedViewController = UINavigationController (rootViewController: FeedViewController())
//        let loginViewController = UINavigationController (rootViewController: LoginViewController())
//        
//        self.viewControllers = [feedViewController, loginViewController]
//        
//        let item1 = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
//        let item2 = UITabBarItem(title: "Profile", image:  UIImage(systemName: "person.fill"), tag: 1)
//
//        feedViewController.tabBarItem = item1
//        loginViewController.tabBarItem = item2
        
        UITabBar.appearance().backgroundColor = .white
    }
    
}

