//
//  TestUserService.swift
//  Navigation
//
//  Created by Vladislav Green on 10/13/22.
//

import UIKit

final class TestUserService: UserService {

var user = User(
    userLogin: "",
    userFullName: "Test Cat",
    userAvatar: UIImage(named: "cat")!,
    userStatus: "One thinks ahead"
    )

    func loginToProfile(ofUser: String) -> User? {
        ofUser == user.userLogin ? user : nil
    }
}

