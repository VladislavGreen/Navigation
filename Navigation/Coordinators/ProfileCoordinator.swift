//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Vladislav Green on 10/26/22.
//

import Foundation
import UIKit

final class ProfileCoordinator: AppCoordinator {

    var childs: [AppCoordinator] = []
    
    var rootCoordinator: RootCoordinator?
    
    func start()  -> UIViewController {
        let loginViewController = LoginViewController()
        let loginFactory = MyLoginFactory()
        loginViewController.loginDelegate = loginFactory.makeLoginInspector()
        let rootViewController = UINavigationController(rootViewController: loginViewController)
        return rootViewController
    }
}
