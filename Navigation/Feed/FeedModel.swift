//
//  FeedModel.swift
//  Navigation
//
//  Created by Vladislav Green on 10/24/22.
//

class FeedModel {
    
    var password: String = "qwerty"
    
    func check(word: String) -> Bool {
        word == password ? true : false
    }
}
