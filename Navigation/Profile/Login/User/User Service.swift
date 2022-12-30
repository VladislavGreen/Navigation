//
//  User Service.swift
//  Navigation
//
//  Created by Vladislav Green on 10/21/22.
//

protocol UserService {
    func loginToProfile(ofUser: String) -> User?
}
