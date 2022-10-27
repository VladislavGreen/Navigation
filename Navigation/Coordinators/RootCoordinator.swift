//
//  RootCoordinator.swift
//  Navigation
//
//  Created by Vladislav Green on 10/26/22.
//

import Foundation
import UIKit

final class RootCoordinator: AppCoordinator {
    
    private weak var transitionHandler: UITabBarController?
    
    // массив для удерживания сильных ссылок
    var childs: [AppCoordinator] = []
    
    var rootCoordinator: RootCoordinator?
    
    // декларируем, что есть дочерние координаторы, чтобы у них был доступ друг к другу через RootCoordinator
    // lazy - чтобы гарантровать отсутствие nil
    lazy var feedCoordinator: FeedCoordinator = FeedCoordinator()
    lazy var profileCoordinator: ProfileCoordinator = ProfileCoordinator()
    
    // декларируем корневой контроллер для всего приложения
    lazy var rootViewController: UIViewController = UITabBarController()
    
    init (transitionHandler: UITabBarController) {
        self.transitionHandler = transitionHandler
    }
    
    // запускаем каждый дочерний координатор собственной функцией start и получаем их в TabBar
    func start() -> UIViewController {
        
        let feedViewController = feedCoordinator.start()
        feedCoordinator.rootCoordinator = self
        feedViewController.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        
        let profileViewController = profileCoordinator.start()
        profileCoordinator.rootCoordinator = self
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        
        (rootViewController as? UITabBarController)?.viewControllers = [feedViewController, profileViewController]
        
        return rootViewController
    }
}
