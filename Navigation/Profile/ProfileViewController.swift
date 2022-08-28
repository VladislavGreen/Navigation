//
//  SecondTabViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationBarDelegate {
    
    let profileHeaderView = ProfileHeaderView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        view.addSubview(profileHeaderView)
        view.sendSubviewToBack(profileHeaderView)
        profileHeaderView.frame = view.bounds
    }
    
    func setupUI() {
        view.backgroundColor = .lightGray

        let profileNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        profileNavigationBar.backgroundColor = .white
        navigationItem.title = "Profile"
        
        view.addSubview(profileNavigationBar)
        
        view.addSubview(profileHeaderView.profileImageView)
        view.addSubview(profileHeaderView.profileImageViewBackground)
        
        view.addSubview(profileHeaderView.userName)
        
        view.addSubview(profileHeaderView.statusTextField)
        
        // Profile pic rounding
        self.roundingUIView(aView: profileHeaderView.profileImageView, cornerRadiusParam: 50)
        self.roundingUIView(aView: profileHeaderView.profileImageViewBackground, cornerRadiusParam: 50)

        setupConstraints()
      }
   
    func setupConstraints() {
        
        view.addSubview(profileHeaderView.userName)
        view.addSubview(profileHeaderView.showStatusButton)
        view.addSubview(profileHeaderView.profileImageView)
        view.addSubview(profileHeaderView.profileImageViewBackground)
        view.addSubview(profileHeaderView.statusTextField)
        
        NSLayoutConstraint.activate([
            
            // Profile Pic and Background
            profileHeaderView.profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 116),
            profileHeaderView.profileImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            profileHeaderView.profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileHeaderView.profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            profileHeaderView.profileImageViewBackground.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            profileHeaderView.profileImageViewBackground.topAnchor.constraint(equalTo: view.topAnchor, constant: 116),
            profileHeaderView.profileImageViewBackground.widthAnchor.constraint(equalToConstant: 100),
            profileHeaderView.profileImageViewBackground.heightAnchor.constraint(equalToConstant: 100),
            profileHeaderView.profileImageViewBackground.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 216),
            
            //  User Name
            profileHeaderView.userName.leftAnchor.constraint(
                equalTo: profileHeaderView.profileImageViewBackground.rightAnchor,
                constant: 16
            ),
            profileHeaderView.userName.topAnchor.constraint(equalTo: view.topAnchor, constant: 127),

            //  Status Button
            profileHeaderView.showStatusButton.topAnchor.constraint(
                equalTo: profileHeaderView.profileImageViewBackground.bottomAnchor,
                constant: 16),
            profileHeaderView.showStatusButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            profileHeaderView.showStatusButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            profileHeaderView.showStatusButton.heightAnchor.constraint(equalToConstant: 50),


            
            //  Status Text Field
            profileHeaderView.statusTextField.leftAnchor.constraint(
                equalTo: profileHeaderView.profileImageViewBackground.rightAnchor,
                constant: 16
            ),
            profileHeaderView.statusTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            profileHeaderView.statusTextField.heightAnchor.constraint(equalToConstant: 50),
            profileHeaderView.statusTextField.bottomAnchor.constraint(
                equalTo: profileHeaderView.showStatusButton.topAnchor,
                constant: -18),
        ])

    }
    
    func roundingUIView(aView: UIView!, cornerRadiusParam: CGFloat!) {
           aView.clipsToBounds = true
           aView.layer.cornerRadius = cornerRadiusParam
       }

}
