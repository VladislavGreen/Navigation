//
//  Post Model.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit

public struct PostModel {
    public var id: Int64
    public var author: String
    public var image: UIImage?
    public var description: String
    public var views: Int
    public var likes: Int
    
    public static var posts: [PostModel] {
        return [
            PostModel(
                id: 1,
                author: "Lazy Poster",
                image: UIImage(named: "card"),
                description: "Вот как выглядит зима в Италии",
                views: 0,
                likes: 0
            ),
            PostModel(
                id: 2,
                author: "Unknown Subscriber",
                image: UIImage(named: "pizza"),
                description: "Жду не дождусь, когда открою коробку!",
                views: 0,
                likes: 0
            ),
            PostModel(
                id: 3,
                author: "Deja Vu",
                image: UIImage(named: "racket"),
                description: "Ещё один неудачный форхенд с задней линии.",
                views: 0,
                likes: 0
            ),
            PostModel(
                id: 4,
                author: "Marbles",
                image: UIImage(named: "quote"),
                description: "Моё любимое сообщение из набора Kyma Pacarana",
                views: 0,
                likes: 0
            ),
        ]
    }
 }


