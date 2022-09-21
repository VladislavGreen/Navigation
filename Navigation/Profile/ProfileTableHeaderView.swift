//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Vladislav Green on 9/12/22.
//

import UIKit

class ProfileHeaderView: UITableViewHeaderFooterView {
    
    //    Аватарка
    
    var avatarImageView: UIImageView = {
        let profilePic = UIImageView()
        let picture = UIImage(named: "cat")
        profilePic.image = picture
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        return profilePic
    }()
    
    var avatarImageViewBackground: UIView = {
        let picBackground = UIView()
        picBackground.layer.borderColor = UIColor.white.cgColor
        picBackground.layer.borderWidth = 3
        picBackground.alpha = 1.0
        picBackground.translatesAutoresizingMaskIntoConstraints = false
        return picBackground
    }()
    
    
    //    Имя пользователя
    
    let fullNameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.text = "Waiter Cat"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //  Текущий статус
    
    var statusLabel: UILabel = {
        let status = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        status.text = "Waiting for something..."
        status.textColor = .gray
        status.font = UIFont.boldSystemFont(ofSize: 14)
        status.translatesAutoresizingMaskIntoConstraints = false
        return status
    }()
    
    
    //    Поле ввода статуса
    
    private var statusText: String = "Waiting for something..."
    
    var statusTextField: UITextField = {
        
        var textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.placeholder = " Type something here"
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.clearsOnBeginEditing = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    //    Кнопка Show status
    
    lazy var setStatusButton: UIButton = {
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
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Profile pic rounding
        self.roundingUIView(aView: avatarImageView, cornerRadiusParam: 50)
        self.roundingUIView(aView: avatarImageViewBackground, cornerRadiusParam: 50)
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: UIControl.Event.editingChanged)

        setupConstraints()
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
        self.contentView.addSubview(self.avatarImageView)
        self.contentView.addSubview(self.avatarImageViewBackground)
        self.contentView.addSubview(self.fullNameLabel)
        self.contentView.addSubview(self.setStatusButton)
        self.contentView.addSubview(self.statusLabel)
        self.contentView.addSubview(self.statusTextField)
        
        NSLayoutConstraint.activate([
            
            // Profile Pic and Background
            self.avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            self.avatarImageViewBackground.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            self.avatarImageViewBackground.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.avatarImageViewBackground.widthAnchor.constraint(equalToConstant: 100),
            self.avatarImageViewBackground.heightAnchor.constraint(equalToConstant: 100),
            self.avatarImageViewBackground.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            
            //  User Name
            self.fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            self.fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),

            //  Status Button
            self.setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 66),
            self.setStatusButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.setStatusButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.setStatusButton.heightAnchor.constraint(equalToConstant: 50),

            //  Current Status
            self.statusLabel.leftAnchor.constraint(equalTo: avatarImageViewBackground.rightAnchor, constant: 16),
            self.statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.statusLabel.heightAnchor.constraint(equalToConstant: 50),
            self.statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -0),
            
            //  Status Text Field
            self.statusTextField.leftAnchor.constraint(equalTo: avatarImageViewBackground.rightAnchor, constant: 16),
            self.statusTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40),
            self.statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -18),

        ])
    }
    
    
    func roundingUIView(aView: UIView!, cornerRadiusParam: CGFloat!) {
           aView.clipsToBounds = true
           aView.layer.cornerRadius = cornerRadiusParam
       }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? "No text"
    }
    
    @objc func buttonPressed() {
        let newStatus = statusText
        statusLabel.text = newStatus
        print(statusLabel as Any)
    }
}
