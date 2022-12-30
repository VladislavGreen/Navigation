//
//  PhotosCollectionViewCell.swift
//  Navigation
//
//  Created by Vladislav Green on 9/20/22.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var postImage: UIImageView = {
       let imageView = UIImageView()
       imageView.contentMode = .scaleAspectFit
       imageView.translatesAutoresizingMaskIntoConstraints = false
       return imageView
   }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with imageView: UIImageView) {
        self.postImage.image = imageView.image
    }
    
    private func setupView() {
        self.addSubview(self.postImage)
        
        NSLayoutConstraint.activate([
            self.postImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.postImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.postImage.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.postImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

