//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Vladislav Green on 9/19/22.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    struct  PhotoCellViewModel {
        let cellLabel: UILabel
        let button: UIButton
        let stackView: UIStackView
    }
    
    private lazy var cellLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
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
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.clipsToBounds = true
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        self.contentView.addSubview(self.stackView)
                
        for index in 0...3 {
            Photo.photos[index].layer.cornerRadius = 6
            Photo.photos[index].clipsToBounds = true
            stackView.addArrangedSubview(Photo.photos[index])
        }
        
        NSLayoutConstraint.activate([
            
            self.cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 12),
            self.cellLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),

            self.button.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            self.button.centerYAnchor.constraint(equalTo: self.cellLabel.centerYAnchor),
            
            ])
        
        NSLayoutConstraint.activate(stackViewConstrants())
    }
    
    private func stackViewConstrants() -> [NSLayoutConstraint] {
        let topAnchorConstraint = self.stackView.topAnchor.constraint(equalTo: self.cellLabel.bottomAnchor, constant: 12)
        let leadingAnchorConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12)
        let trailingAnchorConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12)
        let bottomAnchorConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -12)
        
        let screenWidth = UIScreen.main.bounds.width
        let insets = 12+12+8+8+8 as CGFloat             // insets + spaicing
        let imageWidth = screenWidth/4 - insets
        let imageHeight = imageWidth + 36               // 36 - Label and Button height compensation
        print("❓\(imageHeight)")
        let heightAnchorConstraint = NSLayoutConstraint(item: stackView,
                                                        attribute: .height,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 1.0, constant: imageHeight)
        return [
            topAnchorConstraint, leadingAnchorConstraint, trailingAnchorConstraint, bottomAnchorConstraint, heightAnchorConstraint
        ]
    }
}

