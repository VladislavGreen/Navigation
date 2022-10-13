//
//  TestUserService.swift
//  Navigation
//
//  Created by Vladislav Green on 10/13/22.
//

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

