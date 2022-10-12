//
//  User.swift
//  Navigation
//
//  Created by Vladislav Green on 10/11/22.
//

import UIKit

public class User {
    
    public var userLogin: String
    public var userFullName: String
    public var userAvatar: UIImage
    public var userStatus: String
    
    public init(
        userLogin: String,
        userFullName: String,
        userAvatar: UIImage,
        userStatus: String
    ) {
        self.userLogin = userLogin
        self.userFullName = userFullName
        self.userAvatar = userAvatar
        self.userStatus = userStatus
    }
}


protocol UserService {
    func loginToProfile(ofUser: String) -> User?
}


public class CurrentUserService: UserService {
    
    // база пользователей пока хранится в UserModels
    
    let userLogin: String
    
    var user: User? {
        get {
            let user = loginToProfile(ofUser: userLogin)
            return user
        }
    }

//    init(user: User) {
//        self.user = loginToProfile(ofUser: user.userLogin)
//    }
    
    init(userLogin: String) {
        self.userLogin = userLogin
    }
    
    internal func loginToProfile(ofUser: String) -> User? {
        
        var user: User?
        
        // позже, при формировании профиля, нужно будет гарантировать, что login уникальный
        for i in 0...usersBase.count-1 {
            if usersBase[i].userLogin == ofUser {
                user = usersBase[i]
            } else {
                user = nil
            }
        }
        print(user?.userFullName)
        return user
    }
}

