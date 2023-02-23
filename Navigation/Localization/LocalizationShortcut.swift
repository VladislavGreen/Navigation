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


/*
 Использование префиксного оператора - решение удачное IMO, а вот вставка в типы private enum LocalizedKeys - это излишне и это частичное дублирование информации через строки.
 Также использование принадлежности текстовой метки вида
 ```
 "TextPicker-cancel" = "Cancel";
 ```
 это непрактично в реальных приложениях, так как надпись "Cancel" может повторяться пару десятков раз и нет полезного смысла в паре десятков дублей в Localizable.strings. А если языков в приложении тоже десять, то это еще и растет в геометрической прогрессии.
 Лично мне нравится такой подход как альтернатива префиксному оператору ~
 */
extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
/*
 использование:
 
 let text = "Profile".localized
 */
