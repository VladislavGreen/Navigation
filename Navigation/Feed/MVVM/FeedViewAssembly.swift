//
//  FeedViewAssembly.swift
//  Navigation
//
//  Created by Vladislav Green on 10/27/22.
//

class FeedViewAssembly {
    
    func make() -> FeedViewController {
        let model = FeedPlaceholderModel(text: "Enter Text")
        let viewModel = FeedViewModel(model: model)
        let view = FeedViewController()
        
        view.feedViewModel = viewModel
        
        return view
    }
}
