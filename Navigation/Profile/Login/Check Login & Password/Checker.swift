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
        login = ""
        password = ""
    }

    public func check(loginTried: String, passwordTried: String) throws -> Bool {
        guard loginTried == login else {
            throw AuthorizationError.invalidLogin
        }
        guard passwordTried == password else {
            throw AuthorizationError.invalidPassword
        }
        return true
    }
}
