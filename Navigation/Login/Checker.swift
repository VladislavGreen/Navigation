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
        loginTried == login && passwordTried == password
    }
}
