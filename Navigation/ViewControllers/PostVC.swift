//
//  PostVC.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//
import UIKit

class PostViewController: UIViewController {
 
    var dataSource = Post(title: "Click the button to see the next button")
                               
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "First Text"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50 ))
        button.setTitle("See Info", for: .normal)
        button.layer.cornerRadius = 5
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        setupConstraints()
        titleLabel.text = dataSource.title
        
        self.view.addSubview(self.button)
        self.button.center = self.view.center
        
        view.backgroundColor = .green
    }

    func setupConstraints() {
        view.addSubview(titleLabel)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 500),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func didTapButton() {
        self.present(InfoViewController(), animated: true, completion: nil)
    }

}
