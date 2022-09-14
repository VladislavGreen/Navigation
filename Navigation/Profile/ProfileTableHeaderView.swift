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
    
    var statusTextField : UITextField = {
        
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
    
    
    //  Новая кнопка
    
//    lazy var newButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("New Button", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .systemBlue
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Profile pic rounding
        self.roundingUIView(aView: avatarImageView, cornerRadiusParam: 50)
        self.roundingUIView(aView: avatarImageViewBackground, cornerRadiusParam: 50)
        
        statusTextField.addTarget(self, action: #selector(statusTextChanged(_:)), for: UIControl.Event.editingChanged)

        setupConstraints()
        }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//            createSubviews()
    }
    
    func setupConstraints() {
        
        addSubview(avatarImageView)
        addSubview(avatarImageViewBackground)
        addSubview(fullNameLabel)
        addSubview(setStatusButton)
        addSubview(statusLabel)
        addSubview(statusTextField)
//        addSubview(newButton)
        
        NSLayoutConstraint.activate([
            
            // Profile Pic and Background
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            avatarImageViewBackground.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            avatarImageViewBackground.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            avatarImageViewBackground.widthAnchor.constraint(equalToConstant: 100),
            avatarImageViewBackground.heightAnchor.constraint(equalToConstant: 100),
            avatarImageViewBackground.bottomAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            //  User Name
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),

            //  Status Button
            setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 66),
            setStatusButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            setStatusButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),

            //  Current Status
            statusLabel.leftAnchor.constraint(equalTo: avatarImageViewBackground.rightAnchor, constant: 16),
            statusLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 50),
            statusLabel.bottomAnchor.constraint(equalTo: statusTextField.topAnchor, constant: -0),
            
            //  Status Text Field
            statusTextField.leftAnchor.constraint(equalTo: avatarImageViewBackground.rightAnchor, constant: 16),
            statusTextField.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -18),
            
            //  New Button
//            newButton.leftAnchor.constraint(equalTo: leftAnchor),
//            newButton.rightAnchor.constraint(equalTo: rightAnchor),
//            newButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
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
