//
//  CustomButton.swift
//  Navigation
//
//  Created by Vladislav Green on 10/21/22.
//

import UIKit

struct CustomButtonModel {
    let buttonTitle: String
    let buttonColor: UIColor
    let buttonAction: UIAction
}

final class CustomButton: UIButton {
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton() {
        layer.cornerRadius  = 4
    }
    
    func configureButton(with model: CustomButtonModel) {
        setTitle(model.buttonTitle, for: .normal)
        backgroundColor = model.buttonColor
        addAction(model.buttonAction, for: .touchUpInside)
    }
    
    let buttonTapped = UIAction() { _ in
        
        let feedVC = FeedViewController()
        let postVC = PostViewController()
        feedVC.self.navigationController?.pushViewController(postVC, animated: true)
        
        print("button tapped")
    }
}
