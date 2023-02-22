//
//  TextPicker.swift
//  Navigation
//
//  Created by Vladislav Green on 12/22/22.
//

import UIKit

class TextPicker {
    
    static let defaultPicker = TextPicker()
    
    private enum LocalizedKeys: String {
        case alert = "TextPicker-alert" // "Enter the Author Name"
        case placeholder = "TextPicker-placeholder" // "Enter the name"
        case cancel = "TextPicker-cancel" // "Cancel"
    }
    
    func showPicker(in viewController: UIViewController, completion: @escaping (_ text: String) -> Void) {
        
        let alertController = UIAlertController(
            title: ~LocalizedKeys.alert.rawValue,
            message: nil,
            preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = ~LocalizedKeys.placeholder.rawValue
        }
        
        let actionOK = UIAlertAction(title: "OK", style: .default) {
            action in
            if let text = alertController.textFields?[0].text, text != "" {
                completion(text)
            }
        }
        
        let actionCancel = UIAlertAction(title: ~LocalizedKeys.cancel.rawValue, style: .cancel)
        
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        
        viewController.present(alertController, animated: true)
    }
}

