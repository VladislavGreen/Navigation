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
    

// предыдущая реализация (для истории)
    
//    // база пользователей пока хранится в UserModels
//
//    let userLogin: String
//
//    var user: User? {
//        get {
//            let user = loginToProfile(ofUser: userLogin)
//            return user
//        }
//    }
//
//    init(userLogin: String) {
//        self.userLogin = userLogin
//    }
//
//    internal func loginToProfile(ofUser: String) -> User? {
//
//        var user: User?
//
//        // позже, при формировании профиля, нужно будет гарантировать, что login уникальный
//        for i in 0...usersBase.count-1 {
//            if usersBase[i].userLogin == ofUser {
//                user = usersBase[i]
//            } else {
//                user = nil
//            }
//        }
//        print(user?.userFullName)
//        return user
//    }
//}
