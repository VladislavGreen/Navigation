//
//  Checker.swift
//  Navigation
//
//  Created by Vladislav Green on 10/15/22.
//

public final class Checker {
    
    public static let shared = Checker()
    
    var login: String
    var password: String
    
    private init() {
        login = "q"
        password = "q"
    }

    public func check(loginTried: String, passwordTried: String) -> Bool {
        let userIsRegistered: Bool
        print("Checker func works")
        
        guard loginTried == login, passwordTried == password else {
            userIsRegistered = false
            return userIsRegistered
        }
        userIsRegistered = true
        return userIsRegistered
    }
}
