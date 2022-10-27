//
//  FeedViewModel.swift
//  Navigation
//
//  Created by Vladislav Green on 10/27/22.
//

// VM - View Model Part2

final class FeedViewModel: FeedViewModelProtocol {
    
    // модель
    let model: FeedPlaceholderModel
    
    // binding - как только изменится newPlaceholder - замыкание (определённое во вью слое) обновит название кнопки
    var newPlaceholder: String? {
        didSet {
            self.placeholderNameDidChange?(self)
        }
    }
    
    var placeholderNameDidChange: ((FeedViewModelProtocol) -> ())?
    
    // стартовое значение модели
    init(model: FeedPlaceholderModel) {
        self.model = model
    }
    
    // как только оно изменится - сработает binding и поменяется view слой
    func showNewPlaceholder() {
        newPlaceholder = model.text
    }
}
