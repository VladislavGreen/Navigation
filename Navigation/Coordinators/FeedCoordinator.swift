//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Vladislav Green on 10/26/22.
//

import Foundation
import UIKit

final class FeedCoordinator: AppCoordinator {
    
    var rootCoordinator: RootCoordinator?
    
    var childs: [AppCoordinator] = []
    
    // создаём ViewController, используем сборщик из задачи 7.2, возвращаем туда, откуда создавали
    func start() -> UIViewController {
        let feedViewController = FeedViewAssembly().make()
        let rootViewController = UINavigationController(rootViewController: feedViewController)
        return rootViewController
    }
}
