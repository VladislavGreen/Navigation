//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Vladislav Green on 9/19/22.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
//    struct  PhotoCellViewModel {
//        let cellLabel: UILabel
//        let button: UIButton
//        let collectionView: UICollectionView
//    }
    
    private lazy var cellLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        button.layer.cornerRadius = 6
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private enum Constants {
        static let numberOfItemsInLine: CGFloat = 4
    }
    
    private let dataSource = Photo.photos
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
//        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 50)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "PhotosPreviewCell")
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.delegate = self
        collectionView.dataSource = self
//        collectionView.clipsToBounds = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellLabel.text = nil
    }

    func setupView() {
        
        self.contentView.addSubview(self.cellLabel)
        self.contentView.addSubview(self.button)
        self.contentView.addSubview(self.collectionView)
                
        NSLayoutConstraint.activate([
            
            self.cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.cellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),

            self.button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            self.button.centerYAnchor.constraint(equalTo: self.cellLabel.centerYAnchor),
            
            self.collectionView.topAnchor.constraint(equalTo: self.cellLabel.bottomAnchor, constant: 12),
            self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0),
            self.collectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -0),
            self.collectionView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12),
            self.collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight())
            ])
    }
    
    private func collectionViewHeight() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let insets = layout.sectionInset.left + layout.sectionInset.right + (Constants.numberOfItemsInLine - 1) * layout.minimumInteritemSpacing
        let imageWidth = (screenWidth - insets)/4
        let imageHeight = imageWidth
        print ("👻 screenWidth: \(screenWidth)", "👻 imageHeight: \(imageHeight)")
        return imageHeight
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosPreviewCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }

        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
        cell.backgroundColor = .systemBackground
        cell.setup(with: self.dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let insets = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
        let interItemSpacing = (collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0

        let width = collectionView.frame.width - (Constants.numberOfItemsInLine - 1) * interItemSpacing - insets.left - insets.right
            
        let itemWidth = floor(width / Constants.numberOfItemsInLine)

        print("🍏 \(itemWidth)")

        return CGSize(width: itemWidth, height: itemWidth)
    }
}
        
//        NSLayoutConstraint.activate(stackViewConstrants())
//    }
//
//    private func stackViewConstrants() -> [NSLayoutConstraint] {
////        let topAnchorConstraint = self.stackView.topAnchor.constraint(equalTo: self.cellLabel.bottomAnchor, constant: 12)
////        let leadingAnchorConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12)
////        let trailingAnchorConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12)
////        let bottomAnchorConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
//
//        let screenWidth = UIScreen.main.bounds.width
//        let insets = 12 + 12 + 8 + 8 + 8 as CGFloat             // insets + spaicing
//        let imageWidth = screenWidth/4 - insets
//        let imageHeight = imageWidth + 36               // 36 - Label and Button height compensation
//        let heightAnchorConstraint = NSLayoutConstraint(item: stackView,
//                                                        attribute: .height,
//                                                        relatedBy: .equal,
//                                                        toItem: nil,
//                                                        attribute: .notAnAttribute,
//                                                        multiplier: 1.0, constant: imageHeight)
//        return [
//            topAnchorConstraint, leadingAnchorConstraint, trailingAnchorConstraint, bottomAnchorConstraint, heightAnchorConstraint
//        ]
//    }
//}

