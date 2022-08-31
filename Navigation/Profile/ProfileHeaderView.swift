//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Vladislav Green on 8/25/22.
//

import UIKit

class ProfileHeaderView: UIView {
    
    
    //    Аватарка
    
    var profileImageView: UIImageView = {
        let profilePic = UIImageView()
        let picture = UIImage(named: "cat")
        profilePic.image = picture
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        return profilePic
    }()
    
    var profileImageViewBackground: UIView = {
        let picBackground = UIView()
        picBackground.layer.borderColor = UIColor.white.cgColor
        picBackground.layer.borderWidth = 3
        picBackground.alpha = 1.0
        picBackground.translatesAutoresizingMaskIntoConstraints = false
        return picBackground
    }()
    
    
    //    Имя пользователя
    
    let userName: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.text = "Waiter Cat"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //  Текущий статус
    
    var currentStatus: UILabel = {
        let status = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        status.text = "Waiting for something..."
        status.textColor = .gray
        status.font = UIFont.boldSystemFont(ofSize: 14)
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    
    //    Кнопка Show status
    
    lazy var showStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //    Поле ввода статуса
    
    private var statusText: String = "Waiting for something..."
    
    var statusTextField : UITextField = {
        
        var textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.text = " Type something here"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(profileImageView)
        addSubview(profileImageViewBackground)
        addSubview(userName)
        addSubview(currentStatus)
        addSubview(statusTextField)
        
        // Profile pic rounding
        self.roundingUIView(aView: profileImageView, cornerRadiusParam: 50)
        self.roundingUIView(aView: profileImageViewBackground, cornerRadiusParam: 50)
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: UIControl.Event.editingChanged)

        setupConstraints()
        }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//            createSubviews()
    }

    
    func setupConstraints() {
        
        addSubview(userName)
        addSubview(showStatusButton)
        addSubview(profileImageView)
        addSubview(profileImageViewBackground)
        addSubview(currentStatus)
        addSubview(statusTextField)
        
        NSLayoutConstraint.activate([
            
            // Profile Pic and Background
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 116),
            profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            profileImageViewBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            profileImageViewBackground.topAnchor.constraint(equalTo: topAnchor, constant: 116),
            profileImageViewBackground.widthAnchor.constraint(equalToConstant: 100),
            profileImageViewBackground.heightAnchor.constraint(equalToConstant: 100),
            profileImageViewBackground.bottomAnchor.constraint(equalTo: topAnchor, constant: 216),
            
            //  User Name
            userName.leftAnchor.constraint(
                equalTo: profileImageViewBackground.rightAnchor,
                constant: 16
            ),
            userName.topAnchor.constraint(equalTo: topAnchor, constant: 127),

            //  Status Button
            showStatusButton.topAnchor.constraint(
                equalTo: profileImageViewBackground.bottomAnchor,
                constant: 66),
            showStatusButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            showStatusButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50),

            //  Current Status
            currentStatus.leftAnchor.constraint(
                equalTo: profileImageViewBackground.rightAnchor,
                constant: 16
            ),
            currentStatus.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            currentStatus.heightAnchor.constraint(equalToConstant: 50),
            currentStatus.bottomAnchor.constraint(
                equalTo: statusTextField.topAnchor,
                constant: -0),
            
            //  Status Text Field
            statusTextField.leftAnchor.constraint(
                equalTo: profileImageViewBackground.rightAnchor,
                constant: 16
            ),
            statusTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.bottomAnchor.constraint(
                equalTo: showStatusButton.topAnchor,
                constant: -18),
        ])

    }
    
    
    func roundingUIView(aView: UIView!, cornerRadiusParam: CGFloat!) {
           aView.clipsToBounds = true
           aView.layer.cornerRadius = cornerRadiusParam
       }

    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? "No text"
//        print("text changed")
    }
    
    @objc func buttonPressed() {
        let newStatus = statusText
        currentStatus.text = newStatus
        print(currentStatus as Any)
    }
    
}
