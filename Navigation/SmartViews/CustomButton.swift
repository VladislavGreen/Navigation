//
//  CustomButton.swift
//  Navigation
//
//  Created by Vladislav Green on 10/21/22.
//

import UIKit

final class CustomButton: UIButton {
    
    var buttonAction: () -> Void = {}
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        self.setTitle("Title", for: .normal)
        self.layer.backgroundColor = .none
        self.layer.cornerRadius  = 4
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonTapped () {
        buttonAction()
    }
}
