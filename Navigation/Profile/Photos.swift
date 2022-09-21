//
//  Photos.swift
//  Navigation
//
//  Created by Vladislav Green on 9/19/22.
//
import UIKit

private var imageNames = [
    "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"
]

private var imageViews: [UIImageView]  = {
    var picViews: [UIImageView] = []
    for index in 0..<imageNames.count {
        let picView = UIImageView()
        let name = imageNames[index]
        let pic = UIImage(named: imageNames[index])
        picView.image = pic
        picView.contentMode = .scaleAspectFit
        picView.translatesAutoresizingMaskIntoConstraints = false
        picViews.append(picView)
    }
    return picViews
}()

struct Photo {
    static var photos: [UIImageView] = imageViews
}
