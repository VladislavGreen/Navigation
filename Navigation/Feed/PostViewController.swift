//
//  PostVC.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//
import UIKit

class PostViewController: UIViewController {
 
    
    private enum LocalizedKeys: String {
        case titleLabelText = "PostVC-guessTextPlaceholder"     // "Press the Flame button to see the Info page ↑"
        case barButtonItem = "PostVC-barButtonItem"             //  "Continue"
        case title = "PostVC-title"                             // "Post"
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ~LocalizedKeys.titleLabelText.rawValue
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var barButtonItem = UIBarButtonItem (
        title: ~LocalizedKeys.barButtonItem.rawValue,
        style: .plain,
        target: PostViewController.self,
        action: #selector(didTapButton(sender:))
    )
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let barButtonItemImage = UIImage(systemName: "flame")
        let barButtonItem = UIBarButtonItem(image: barButtonItemImage, style: .plain, target: self, action: #selector(didTapButton))
        navigationItem.rightBarButtonItem = barButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    func setupUI() {
        setupConstraints()
        view.backgroundColor = .green
        navigationItem.title = ~LocalizedKeys.title.rawValue
    }

    func setupConstraints() {
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func didTapButton(sender: UIBarButtonItem) {
        self.present(InfoViewController(), animated: true, completion: nil)
    }

}
