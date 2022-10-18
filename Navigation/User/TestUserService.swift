//
//  TestUserService.swift
//  Navigation
//
//  Created by Vladislav Green on 10/13/22.
//

//import UIKit
//
//final class TestUserService: UserService {
//
//    let user = User(
//        userLogin: "Mico",
//        userFullName: "Mico Myst",
//        userAvatar: UIImage(named: "cat")!,
//        userStatus: "Ready to anything"
//    )
//
//    func getUser(login: String) -> User? {
//            login == user.userLogin ? user : nil
//        }
//}
//  С наскока не получилось - посмотреть потом


public class TestUserService: UserService {

    let userLogin: String

    var user: User? {
        get {
            let user = loginToProfile(ofUser: userLogin)
            return user
        }
    }

    init(userLogin: String) {
        self.userLogin = userLogin
    }

    internal func loginToProfile(ofUser: String) -> User? {

        var user: User?

        for i in 0...usersBase.count-1 {
            if usersBase[i].userLogin == ofUser {
                user = usersBase[i]
            } else {
                user = nil
            }
        }
        print("Тест-режим: \(user?.userFullName)")
        return user
    }
}

