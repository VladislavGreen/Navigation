//
//  FeedViewModelProtocol.swift
//  Navigation
//
//  Created by Vladislav Green on 10/27/22.
//

// VM - View Model Part1

protocol FeedViewModelProtocol {
    
    var newPlaceholder: String? { get }
    
    var placeholderNameDidChange: ((FeedViewModelProtocol) -> ())? { get set }
    
    func showNewPlaceholder()
}
