//
//  FirstTabViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.backgroundColor = .black
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .default
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.tintColor = .gray
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.placeholder = " Password"
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .whileEditing
//        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var checkGuessButton: UIButton = {
        let button = UIButton()
        button.setTitle("checkGuess", for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(checkGuessButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var lightLabel: UILabel = {
        let label = UILabel()
        label.text = "Result"
        label.textColor = label.backgroundColor
        label.clipsToBounds = true
        label.backgroundColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
//    private var firstButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("First Button", for: .normal)
//        button.layer.cornerRadius = 4
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//        button.backgroundColor = .systemGreen
//        return button
//    }()
//
//    private var secondButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Second Button", for: .normal)
//        button.layer.cornerRadius = 4
//        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
//        button.backgroundColor = .systemYellow
//        return button
//    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstButton = CustomButton()
        firstButton.configureButton(
            with: CustomButtonModel(
                buttonTitle: "First Button",
                buttonColor: .systemGreen,
                buttonAction: firstButton.buttonTapped
            )
        )
        
        let secondButton = CustomButton()
        secondButton.configureButton(
            with: CustomButtonModel(
                buttonTitle: "Second Button",
                buttonColor: .systemYellow,
                buttonAction: secondButton.buttonTapped
            )
        )
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(lightLabel)
        buttonsStackView.addArrangedSubview(passwordTextField)
        buttonsStackView.addArrangedSubview(checkGuessButton)
        buttonsStackView.addArrangedSubview(firstButton)
        buttonsStackView.addArrangedSubview(secondButton)
        
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    private func getPasswordTextFieldValue() -> String {
        let value = passwordTextField.text!
        return value
    }
    
    @objc private func checkGuessButtonPressed() {
        let passwordTried = getPasswordTextFieldValue()
        print(passwordTried)
        
        let feedModel = FeedModel()
        if feedModel.check(word: passwordTried) == true {
            lightLabel.backgroundColor = .green
        } else {
            lightLabel.backgroundColor = .red
        }
    }
    
    
//    @objc func didTapButton() {
//        let vc = PostViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    

}
