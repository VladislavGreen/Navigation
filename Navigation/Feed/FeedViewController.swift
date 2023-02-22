//
//  FirstTabViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    
    private enum LocalizedKeys: String {
        case guessTextPlaceholder = "FeedVC-guessTextPlaceholder"   // _Password
        case lightLabelText = "FeedVC-lightLabelText"               //  Result
        case firstButtonTitle = "FeedVC-firstButtonTitle"           // "Clear All Users"
        case secondButtonTitle = "FeedVC-secondButtonTitle"         //"Tatooine Statistics"
        case checkButtonTitle = "FeedVC-checkButtonTitle"           //"Check Guess"
    }
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var guessTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.tintColor = .gray
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.placeholder = ~LocalizedKeys.guessTextPlaceholder.rawValue
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
//        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var lightLabel: UILabel = {
        let label = UILabel()
        label.text = ~LocalizedKeys.lightLabelText.rawValue
        label.textColor = label.backgroundColor
        label.clipsToBounds = true
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstButton = CustomButton()
        firstButton.backgroundColor = .systemGreen
        firstButton.setTitle(~LocalizedKeys.firstButtonTitle.rawValue, for: .normal)
        firstButton.buttonAction = {
            let realmManager = RealmManager()
            realmManager.clearUsersRealm()
//            print("all realm users have been deleted")
//            let vc = LoginViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let secondButton = CustomButton()
        secondButton.backgroundColor = .systemYellow
        secondButton.setTitle(~LocalizedKeys.secondButtonTitle.rawValue, for: .normal)
        secondButton.buttonAction = { [unowned self] in
            let vc = PostViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let checkGuessButton = CustomButton()
        checkGuessButton.backgroundColor = .systemBlue
        checkGuessButton.setTitle(~LocalizedKeys.checkButtonTitle.rawValue, for: .normal)
        checkGuessButton.buttonAction = { [unowned self] in
            let feedModel = FeedModel()
            let passwordTried = getPasswordTextFieldValue()
            print(passwordTried)
            
            if feedModel.check(word: passwordTried) == true {
                lightLabel.backgroundColor = .green
            } else {
                lightLabel.backgroundColor = .red
            }
        }
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(lightLabel)
        buttonsStackView.addArrangedSubview(guessTextField)
        buttonsStackView.addArrangedSubview(checkGuessButton)
        buttonsStackView.addArrangedSubview(firstButton)
        buttonsStackView.addArrangedSubview(secondButton)
        
        self.setupGestures()

        
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func setupGestures() {
        self.hideKeyboardWhenTappedAround()
    }
    
    private func getPasswordTextFieldValue() -> String {
        let value = guessTextField.text!
        return value
    }
}


extension FeedViewController {
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(FeedViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc
    private func dismissKeyboard() {
        view.endEditing(true)
    }
}
