//
//  InfoVC.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit

class InfoViewController: UIViewController {
 
    private lazy var button: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50 ))
        button.setTitle("See Info", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGreen
        return button
    }()
    
    let alertController = UIAlertController(title: "It's time to choose!", message: "Left or right? Press the button:", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        setupAlertConfiguration()
        setupConstraints()
        addTargets()
                
        view.backgroundColor = .systemRed
        
        self.view.addSubview(self.button)
        self.button.center = self.view.center
    }
    
    func setupAlertConfiguration() {
        alertController.addAction(UIAlertAction(title: "LEFT", style: .default, handler: { _ in
           print("LEFT")
        }))
        alertController.addAction(UIAlertAction(title: "RIGHT", style: .default, handler: { _ in
           print("RIGHT")
        }))
    }
    
    func addTargets() {
        button.addTarget(self, action: #selector(addTarget), for: .touchUpInside)
    }
    
    func setupConstraints() {
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func addTarget() {
        self.present(alertController, animated: true, completion: nil)
    }
}
