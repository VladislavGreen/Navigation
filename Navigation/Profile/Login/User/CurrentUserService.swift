//
//  CurrentUserService.swift
//  Navigation
//
//  Created by Vladislav Green on 10/21/22.
//

import UIKit

final class CurrentUserService: UserService {
    
var user = User(
    userLogin: "",
    userFullName: "Deku Tree",
    userAvatar: UIImage(named: "cat")!,
    userStatus: "One thinks ahead"
    )

    func loginToProfile(ofUser: String) -> User? {
        ofUser == user.userLogin ? user : nil
    }
}

