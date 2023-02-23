//
//  AdaptiveColorsExtension.swift
//  Navigation
//
//  Created by Vladislav Green on 2/23/23.
//

import UIKit


extension UIColor {
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else {
            return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
        }
    }
}
