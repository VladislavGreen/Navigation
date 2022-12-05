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

            alertConfiguration = UIAlertController(title: "Not so fast",
                                          message: "Empty fields detected. Please fill them.",
                                          preferredStyle: .alert)
            alertConfiguration.addAction(UIAlertAction(title: "Try",
                                          style: .cancel,
                                          handler: {_ in
            }))
            showLoginAlert(alertConfiguration: alertConfiguration)

            print("Уведомление о пустых полях")
            return
        }

        // Проверка Login на email-ность
        guard loginTried.isValidEmail else {

            alertConfiguration = UIAlertController(title: "You've made a typo",
                                          message: "Check your email spelling please",
                                          preferredStyle: .alert)
            alertConfiguration.addAction(UIAlertAction(title: "Check",
                                          style: .cancel,
                                          handler: {_ in
            }))
            showLoginAlert(alertConfiguration: alertConfiguration)

            print("Wrong Email")
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
                    return
                }
                print("You have signed in")
                print("Входим в профиль")
            })
        }))
        alertConfiguration.addAction(UIAlertAction(title: "Cancel",
                                      style: .cancel,
                                      handler: {_ in
        }))
        showLoginAlert(alertConfiguration: alertConfiguration)
    }


    private func showLoginAlert(alertConfiguration: UIAlertController ) {
        
//        let scenes = UIApplication.shared.connectedScenes
//        let windowScene = scenes.first as? UIWindowScene
//        window = windowScene?.windows.first(where: { $0.isKeyWindow })?.windowScene
        
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




// Использован видео-урок https://www.youtube.com/watch?v=ife5YK-Keng 19:22

//        // Проверка на пустые поля в Login и Password
//        guard !loginTried.isEmpty, !passwordTried.isEmpty else {
//            print("Уведомление о пустых полях")
//            return
//        }
//
//        // Проверка Login на email-ность
//        guard loginTried.isValidEmail else {
//            print("Wrong Email")
//            return
//        }
//
//        //  Авторизуемся
//        FirebaseAuth.Auth.auth().signIn(withEmail: loginTried, password: passwordTried, completion: { result, error in
//
//            guard error == nil else {
//                print("Предложение создать аккаунт")
//                self.showCreateAccount(email: loginTried, password: passwordTried)
//                return
//            }
//
//            print("Входим в профиль")
//
//        })
//


//    //  Создаём аккаунт и авторизуемся в него
//    func showCreateAccount(email: String, password: String) {
//        let alert = UIAlertController(title: "Create Account",
//                                      message: "Would you like to create an account?",
//                                      preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Continue",
//                                      style: .default,
//                                      handler: {_ in
//            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { result, error in
//
//                guard error == nil else {
//                    // show account creation alert
//                    print("Account creation failed")
//                    return
//                }
//
//                print("You have signed in")
//                print("Входим в профиль")
//
//
//            })
//        }))
//        alert.addAction(UIAlertAction(title: "Cancel",
//                                      style: .cancel,
//                                      handler: {_ in
//
//        }))
//
//        present(alert, animated: true)
//    }
