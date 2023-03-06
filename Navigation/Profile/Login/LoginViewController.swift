//
//  LogInViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 9/7/22.
//

import UIKit
import RealmSwift
import KeychainSwift


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    private let localAuthorizationService = LocalAuthorizationService()
    
    lazy var realmManager = RealmManager()
    
    lazy var realm = {
        
        let keychain = KeychainSwift()
        var key = keychain.getData("Key")
        if key == nil {
            key = Data(count: 64)
            _ = key!.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
                SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!) }
            keychain.set(key!, forKey: "Key")
        }
        
        let config = Realm.Configuration(encryptionKey: key)
        let realm = try! Realm(configuration: config)
        return realm
    }
    
    private lazy var logoImageView: UIImageView = {
        let picView = UIImageView()
        let pic = UIImage(named: "logo")
        picView.image = pic
        picView.translatesAutoresizingMaskIntoConstraints = false
        return picView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var stackViewTextFields: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        stackView.layer.cornerRadius = 10
        stackView.axis = .vertical
        stackView.layer.borderColor = UIColor.createColor(lightMode: .lightGray, darkMode: .white).cgColor
        stackView.layer.borderWidth = 0.7
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        textField.font = .systemFont(ofSize: 16)
        textField.tintColor = UIColor(named: "Accent Color")
        textField.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(
            string: "LoginVC-loginPlaceholder".localized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.createColor(lightMode: .gray, darkMode: .lightGray)]
        )
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.createColor(lightMode: .lightGray, darkMode: .white)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        textField.font = .systemFont(ofSize: 16)
        textField.tintColor = .gray
        textField.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        textField.autocapitalizationType = .none
        textField.attributedPlaceholder = NSAttributedString(
            string: "LoginVC-passwordPlaceholder".localized,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.createColor(lightMode: .black, darkMode: .lightGray)]
        )
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        let imageAlpha1 = UIImage(named: "blue_pixel")as UIImage?
        let imageAlpha08 = UIImage(named: "blue_pixel")!.alpha(0.8)
        button.setBackgroundImage(imageAlpha1, for: .normal)
        button.setBackgroundImage(imageAlpha08, for: .disabled)
        button.setBackgroundImage(imageAlpha08, for: .highlighted)
        button.setBackgroundImage(imageAlpha08, for: .selected)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("LoginVC-button".localized, for: .normal)
        button.setTitleColor(UIColor.createColor(lightMode: .white, darkMode: .white), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var biometricButton: UIButton = {
        let button = UIButton()
        let imageAlpha1 = UIImage(named: "blue_pixel")as UIImage?
        let imageAlpha08 = UIImage(named: "blue_pixel")!.alpha(0.8)
        button.setBackgroundImage(imageAlpha1, for: .normal)
        button.setBackgroundImage(imageAlpha08, for: .disabled)
        button.setBackgroundImage(imageAlpha08, for: .highlighted)
        button.setBackgroundImage(imageAlpha08, for: .selected)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.setTitle("LoginVC: use biometry".localized, for: .normal)
        button.setTitleColor(UIColor.createColor(lightMode: .white, darkMode: .white), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(biometricButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let alertController = UIAlertController(
        title: "LoginVC-alert".localized,
        message: "LoginVC-message".localized,
        preferredStyle: .alert
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBiometricButtonImage()
        checkUserRealm()
        setupUI()
        
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didShowKeyboard(_:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didHideKeyboard(_:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    
    private func setBiometricButtonImage() {
        
        localAuthorizationService.canEvaluate { (_, BiometricType, _) in
            var image = UIImage()
            
            switch BiometricType {
            case .touchID:
                image = (UIImage(systemName: "touchid")?.withTintColor(.white, renderingMode: .alwaysOriginal))!
            case .faceID:
                image = (UIImage(systemName: "faceid")?.withTintColor(.white, renderingMode: .alwaysOriginal))!
            case .none, .unknown:
                image = (UIImage(systemName: "circle")?.withTintColor(.white, renderingMode: .alwaysOriginal))!
                biometricButton.backgroundColor = .gray
            }
            
            DispatchQueue.main.async {
                self.biometricButton.setImage(image, for: .normal)
            }
            
            biometricAuth()
        }
    }
    
    
    private func checkUserRealm() {
        
        realmManager.loadUserRealm(realm: realm())
        
        let userRealm = realmManager.usersRealm
        guard userRealm.isEmpty == false else {
            print("Userbase is empty")
            return }
        
        logIn()
    }
    
    
    private func setupUI() {
        
        view.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        setupGestures()
        setupAlertConfiguration()

        let loginNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0))
        loginNavigationBar.isHidden = true
        
        view.addSubview(loginNavigationBar)
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(stackViewTextFields)
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(biometricButton)
        
        stackViewTextFields.addArrangedSubview(loginTextField)
        stackViewTextFields.addArrangedSubview(separatorView)
        stackViewTextFields.addArrangedSubview(passwordTextField)
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 160),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: 260),
                        
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 380),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 216.5),
            
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            biometricButton.heightAnchor.constraint(equalToConstant: 50)

        ])
    }
    
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
           print("Ok")
        }))
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            let loginButtonBottomPointY =
                self.stackView.frame.origin.y + self.button.frame.origin.y + self.button.frame.height + 16
            
            let keyboardOriginY = self.view.frame.height - keyboardHeight

            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 16
            : 0

            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }

    @objc private func didHideKeyboard(_ notification: Notification) {
        self.forcedHidingKeyboard()
    }

    @objc private func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    @objc private func buttonPressed() {
        
        let loginTried = loginTextField.text!
        let passwordTried = passwordTextField.text!
        print(loginTried, passwordTried)
        
        realmManager.saveUserRealm(login: loginTried, password: passwordTried, realm: realm())
        
        logIn()
    }
    
    @objc
    private func biometricButtonPressed() {
        self.biometricAuth()
    }
    
    func biometricAuth() {
        localAuthorizationService.authorizeIfPossible { authorizationFinished, errorString  in
            guard authorizationFinished else {
                self.biometricAlert(
                    title: "Error",
                    message: errorString ?? "Face ID/Touch ID may not be configured",
                    okActionTitle: "Ok")
                return
            }
            self.logIn()
        }
    }
    
    func logIn() {
        
        #if DEBUG
        let currentUser = TestUserService()
        #else
        let currentUser = CurrentUserService()
        #endif

        let user = currentUser.user
        
        let viewController = ProfileViewController()
        viewController.user = user
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func biometricAlert(
        title: String,
        message: String,
        okActionTitle: String
    ) {
        let alertView = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: okActionTitle,
            style: .default
        )
        alertView.addAction(okAction)
        present(
            alertView,
            animated: true
        )
    }
}


extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
