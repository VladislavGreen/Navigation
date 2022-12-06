//
//  CheckerService.swift
//  Navigation
//
//  Created by Vladislav Green on 12/3/22.
//  Использован видео-урок https://www.youtube.com/watch?v=ife5YK-Keng 19:22


import UIKit
import FirebaseAuth

protocol CheckerServiceProtocol {
    
    func checkCredentials(
//        _ sender: LoginViewController,
        loginTried: String,
        passwordTried: String,
        completion: @escaping (_ result: Result<Bool, AuthorizationError>) -> Void)
}


class CheckerService: CheckerServiceProtocol {
    
    public static let shared = CheckerService()
    
    private lazy var alertConfiguration = UIAlertController()
    
    //  Проверки
    func checkCredentials(loginTried: String, passwordTried: String, completion: @escaping (_ result: Result<Bool, AuthorizationError>) -> Void) {
        
        // Проверка на пустые поля в Login и Password
        guard !loginTried.isEmpty, !passwordTried.isEmpty else {
            
            print("Уведомление о пустых полях")
            
            alertConfiguration = UIAlertController(title: "Not so fast",
                                                   message: "Empty fields detected. Please fill them.",
                                                   preferredStyle: .alert)
            alertConfiguration.addAction(UIAlertAction(title: "Try",
                                                       style: .cancel,
                                                       handler: {_ in
            }))
            showLoginAlert(alertConfiguration: alertConfiguration)
            return
        }
        
        // Проверка Login на email-ность
        guard loginTried.isValidEmail else {
            
            print("Wrong Email")
            
            alertConfiguration = UIAlertController(title: "You've made a typo",
                                                   message: "Check your email spelling please",
                                                   preferredStyle: .alert)
            alertConfiguration.addAction(UIAlertAction(title: "Check",
                                                       style: .cancel,
                                                       handler: {_ in
            }))
            showLoginAlert(alertConfiguration: alertConfiguration)
            
            return
        }
        
        //  Авторизация
        FirebaseAuth.Auth.auth().signIn(withEmail: loginTried, password: passwordTried, completion: { result, error in
            
            guard error == nil else {
                print("Вызываем метод создания аккаунта")
                self.signUp(loginTried: loginTried, passwordTried: passwordTried)
                return
            }
            
            print("Входим в профиль")
            
            // прячем клавиатуру
            UIApplication
                .shared
                .sendAction(#selector(UIApplication.resignFirstResponder),
                            to: nil, from: nil, for: nil)
            
            NotificationCenter.default.post(name: NSNotification.Name("ProfileAssessAllowed"), object: nil)
            
            return
        })
    }
    
    
    
    //  Создание аккаунта и авторизация
    private func signUp(loginTried: String, passwordTried: String) {
        
        alertConfiguration = UIAlertController(title: "Create Account",
                                               message: "Would you like to create an account?",
                                               preferredStyle: .alert)
        
        alertConfiguration.addAction(UIAlertAction(title: "Continue",
                                                   style: .default,
                                                   handler: {_ in
            FirebaseAuth.Auth.auth().createUser(withEmail: loginTried, password: passwordTried, completion: { result, error in
                
                guard error == nil else {
                    // show account creation alert
                    print("Account creation failed")
                    
                    self.alertConfiguration = UIAlertController(title: "Something wrong",
                                                           message: "Try to create another password",
                                                           preferredStyle: .alert)
                    self.alertConfiguration.addAction(UIAlertAction(title: "Try again",
                                                               style: .cancel,
                                                               handler: {_ in
                    }))
                    self.showLoginAlert(alertConfiguration: self.alertConfiguration)
                    return
                }
                print("You have signed in")
                print("Входим в профиль")
                NotificationCenter.default.post(name: NSNotification.Name("ProfileAssessAllowed"), object: nil)
            })
        }))
        alertConfiguration.addAction(UIAlertAction(title: "Cancel",
                                                   style: .cancel,
                                                   handler: {_ in
        }))
        showLoginAlert(alertConfiguration: alertConfiguration)
    }
    
    
    private func showLoginAlert(alertConfiguration: UIAlertController ) {
        
        if var topController = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.present(alertConfiguration, animated: true, completion: nil)
        }
    }
}


// Экстеншен для проверки Login (eMail)
extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

