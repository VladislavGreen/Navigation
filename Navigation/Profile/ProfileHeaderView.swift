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
//        picBackground.layer.cornerRadius = 50
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
    
    
    //    Поле статуса
    
    var statusTextField : UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.text = "Waiting for something..."
        textField.textColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    
    
    
    
    
    
    
    @objc func buttonPressed() {
        let currentStatus = statusTextField.text!
        print(currentStatus)
    }
    
}
