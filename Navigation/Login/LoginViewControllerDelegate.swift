//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Vladislav Green on 10/15/22.
//

protocol LoginViewControllerDelegate: AnyObject {
    
    func check(
        _ sender: LoginViewController,
        loginTried: String,
        passwordTried: String
    ) -> Bool
    
}

