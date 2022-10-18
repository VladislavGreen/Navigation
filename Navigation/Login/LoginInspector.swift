//
//  LoginInspector.swift
//  Navigation
//
//  Created by Vladislav Green on 10/15/22.
//


struct LoginInspector: LoginViewControllerDelegate {
    
    func check(
        _ sender: LoginViewController,
        loginTried: String,
        passwordTried: String
    ) -> Bool {
        return Checker.shared.check(loginTried: loginTried, passwordTried: passwordTried)
    }
}

