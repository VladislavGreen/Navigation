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
//        return  Checker.shared.check(loginTried: loginTried, passwordTried: passwordTried)
        
        do {
            return try Checker.shared.check(loginTried: loginTried, passwordTried: passwordTried)
        }
        catch AuthorizationError.invalidLogin {
            print(AuthorizationError.invalidLogin.description)
            return false
        }
        catch AuthorizationError.invalidPassword {
            print(AuthorizationError.invalidPassword.description)
            return false
        }
        catch {
            return false
        }
    }
}

