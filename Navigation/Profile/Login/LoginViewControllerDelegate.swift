//
//  LoginViewControllerDelegate.swift
//  Navigation
//
//  Created by Vladislav Green on 10/15/22.
//

protocol LoginViewControllerDelegate {
    
    func checkCredentials(
        _ sender: LoginViewController,
        loginTried: String,
        passwordTried: String,
        completion: @escaping (_ result: Result<Bool, AuthorizationError>) -> Void)
}

