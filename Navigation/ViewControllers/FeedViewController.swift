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
    
    private var firstButton: UIButton = {
        let button = UIButton()
        button.setTitle("First Button", for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    private var secondButton: UIButton = {
        let button = UIButton()
        button.setTitle("Second Button", for: .normal)
        button.layer.cornerRadius = 4
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .systemYellow
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(buttonsStackView)
        buttonsStackView.addArrangedSubview(firstButton)
        buttonsStackView.addArrangedSubview(secondButton)
        
        NSLayoutConstraint.activate([
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

        ])

    }
    
    @objc private func didTapButton() {
        let vc = PostViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
