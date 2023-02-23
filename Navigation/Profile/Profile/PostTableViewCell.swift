//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Vladislav Green on 9/12/22.
//

import UIKit
import CoreData


class PostTableViewCell: UITableViewCell {
    
    
//    private enum LocalizedKeys: String {
//        case views = "PostTVC-views" // "Views: "
////        case likes = "PostTVC-likes" // "Likes: "
//
//    }
    
    struct ViewModel {
        let id: Int64
        let author: String
        let image: UIImage?
        let description: String
        let views: Int
        let likes: Int
    }
    
    var postID: Int64?
    
    var postName: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
     var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var postImageBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     var postText: UILabel = {
        let titleLabel = UILabel()
         titleLabel.font = UIFont.systemFont(ofSize: 16)
         titleLabel.textColor = .systemGray
         titleLabel.numberOfLines = 0
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
     var postViews: UILabel = {
        let viewsLabel = UILabel()
         viewsLabel.translatesAutoresizingMaskIntoConstraints = false
        return viewsLabel
    }()
    
     var postLikes: UILabel = {
        let likesLabel = UILabel()
         likesLabel.translatesAutoresizingMaskIntoConstraints = false
        return likesLabel
    }()
 
    
    private var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.postID = nil
        self.postName.text = nil
        self.postImage.image = nil
        self.postText.text = nil
        self.postViews.text = nil
        self.postLikes.text = nil
    }
    
    
    func setup(with viewModel: ViewModel) {
        self.postID = viewModel.id
        self.postName.text = viewModel.author
        self.postImage.image = viewModel.image
        self.postText.text = viewModel.description
        
//        self.postViews.text = ~LocalizedKeys.views.rawValue + "\(viewModel.views)"
        self.postViews.text = "PostTVC-views".localized + "\(viewModel.views)"
        
        
        let likes = pluralize(using: "Counting_likes", number: viewModel.likes)
        self.postLikes.text = likes
    }
    
    
    private func pluralize(using localizedString: String, number: Int) -> String {
        let formattedString = NSLocalizedString(localizedString, comment: "")
        let string = String(format: formattedString, number)
//        print(string)
        return string
    }
    
    
    private func setupView() {
    
        self.contentView.addSubview(self.postName)
        self.contentView.addSubview(self.postImageBackground)
        self.contentView.addSubview(self.postImage)
        self.contentView.addSubview(self.postText)
        self.contentView.addSubview(self.postViews)
        self.contentView.addSubview(self.postLikes)
        
        NSLayoutConstraint.activate([
            self.postName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.postName.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.postName.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.postName.bottomAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 36),

            self.postImageBackground.topAnchor.constraint(equalTo: self.postName.bottomAnchor,constant: 12),
            self.postImageBackground.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.postImageBackground.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.postImageBackground.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            self.postImageBackground.heightAnchor.constraint(equalTo: self.contentView.widthAnchor),
            
            self.postImage.centerYAnchor.constraint(equalTo: self.postImageBackground.centerYAnchor),
            self.postImage.leadingAnchor.constraint(equalTo: self.postImageBackground.leadingAnchor),
            self.postImage.trailingAnchor.constraint(equalTo: self.postImageBackground.trailingAnchor),
            self.postImage.widthAnchor.constraint(equalTo: self.postImageBackground.widthAnchor),
            self.postImage.bottomAnchor.constraint(equalTo: self.postImageBackground.bottomAnchor),
            
            self.postText.topAnchor.constraint(equalTo: self.postImageBackground.bottomAnchor,constant: 16),
            self.postText.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.postText.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.postText.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -48),
            
            self.postViews.topAnchor.constraint(equalTo: self.postText.bottomAnchor, constant:  16),
            self.postViews.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            
            self.postLikes.topAnchor.constraint(equalTo: self.postText.bottomAnchor, constant:  16),
            self.postLikes.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.postLikes.centerXAnchor.constraint(equalTo: self.postViews.centerXAnchor),
        ])
    }
}
