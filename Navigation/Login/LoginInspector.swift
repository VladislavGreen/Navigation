//
//  LoginInspector.swift
//  Navigation
//
//  Created by Vladislav Green on 10/15/22.
//


class LoginInspector: LoginViewControllerDelegate {
    
    func check(
        _ sender: LoginViewController,
        loginTried: String,
        passwordTried: String
    ) -> Bool {
        print("Login Inspector works")
        return Checker.shared.check(loginTried: loginTried, passwordTried: passwordTried)
    }
}

