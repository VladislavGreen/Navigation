//
//  LocalizationShortcut.swift
//  Navigation
//
//  Created by Vladislav Green on 2/21/23.
//

import Foundation

prefix operator ~
prefix func ~ (string: String) -> String {
    return NSLocalizedString(string, comment: "")
}
