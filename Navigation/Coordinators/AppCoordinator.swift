//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Vladislav Green on 10/26/22.
//

import Foundation

protocol AppCoordinator {
    
    var childs: [AppCoordinator] { get set }
}
