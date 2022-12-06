//
//  LoginInspector.swift
//  Navigation
//
//  Created by Vladislav Green on 10/15/22.
//


struct LoginInspector: LoginViewControllerDelegate {
    
    func checkCredentials(
        _ sender: LoginViewController,
        loginTried: String,
        passwordTried: String,
        completion: @escaping (_ result: Result<Bool, AuthorizationError>) -> Void)
    {
        return CheckerService.shared.checkCredentials(loginTried: loginTried, passwordTried: passwordTried)
        {
            result in
                switch result {
                case .success(true):
                    print("Success from LoginInspector")
                case .failure(AuthorizationError.invalidLoginOrPassword):
                    print(AuthorizationError.invalidLoginOrPassword.description)
                case .success(false):
                    print("No Success from LoginInspector")
            }
        }
    }
}


