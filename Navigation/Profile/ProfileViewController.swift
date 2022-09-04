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
        let profileNavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        profileNavigationBar.backgroundColor = .white
        navigationItem.title = "Profile"

        view.addSubview(profileNavigationBar)
        
        view.addSubview(profileHeaderView)
        view.sendSubviewToBack(profileHeaderView)
        view.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
        ])

    }

}
