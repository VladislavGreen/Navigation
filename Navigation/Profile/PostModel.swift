//
//  Post Model.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit

struct PostModel {
    var author: String
    var image: UIImage?
    var description: String
    var views: Int
    var likes: Int
    
    static var posts: [PostModel] {
        return [
            PostModel(
                author: "Lazy Poster",
                image: UIImage(named: "card"),
                description: "Вот как выглядит зима в Италии",
                views: 0,
                likes: 0
            ),
            PostModel(
                author: "Unknown Subscriber",
                image: UIImage(named: "pizza"),
                description: "Жду не дождусь, когда открою коробку!",
                views: 0,
                likes: 0
            ),
            PostModel(
                author: "Deja Vu",
                image: UIImage(named: "racket"),
                description: "Ещё один неудачный форхенд с задней линии.",
                views: 0,
                likes: 0
            ),
            PostModel(
                author: "Marbles",
                image: UIImage(named: "quote"),
                description: "Моё любимое сообщение из набора Kyma Pacarana",
                views: 0,
                likes: 0
            ),
        ]
    }
 }


