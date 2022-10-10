//
//  SecondTabViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit
import StorageService
import SnapKit

class ProfileViewController: UIViewController, UINavigationBarDelegate {
    
    let postTableViewCell = PostTableViewCell()
    
    private let dataSource = Photo.photos
    
    private lazy var avatarImageView: UIImageView = {
        let profilePic = UIImageView()
        let picture = UIImage(named: "cat")
        profilePic.image = picture
        profilePic.isUserInteractionEnabled = true
//        profilePic.translatesAutoresizingMaskIntoConstraints = false
        profilePic.alpha = 0.02
        return profilePic
    }()
    
    private var avatarCenterStart = CGPoint()
    private var avatarBoundsStart = CGRect()
    
    private var isImageViewIncreased = false
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.isHidden = true
        view.alpha = 0
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "clear"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 0
        button.clipsToBounds = true
        button.alpha = 0
        button.isHidden = true
        button.addTarget(self, action: #selector(self.didTapClearButton), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        #if DEBUG
            tableView.backgroundColor = .lightGray
        #else
            tableView.backgroundColor = .systemBackground
        #endif
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupGestures()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.button)
        self.view.addSubview(self.avatarImageView)
        self.roundingUIView(aView: avatarImageView, cornerRadiusParam: 50)
        
        avatarImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().inset(48)
            make.left.equalToSuperview().inset(16)
            make.width.height.equalTo(100)
        }
        
        backgroundView.snp.makeConstraints { (make) -> Void in
            make.top.left.width.height.equalToSuperview()
        }
        
        button.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().inset(40)
            make.right.equalToSuperview()
            make.width.height.equalTo(64)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.left.width.height.equalToSuperview()
        }
    }
    
    func roundingUIView(aView: UIView!, cornerRadiusParam: CGFloat!) {
           aView.clipsToBounds = true
           aView.layer.cornerRadius = cornerRadiusParam
       }
    
    private func setupGestures() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTapGesture(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 2
        self.avatarImageView.addGestureRecognizer(tapGestureRecognizer)
            }
    
    @objc private func handleTapGesture(_ gestureRecognizer: UITapGestureRecognizer) -> () {
        
        self.button.isEnabled = true
        self.avatarImageView.alpha = 1
        self.avatarIncreasing()
    }
    
    @objc private func didTapClearButton() {
        self.button.isEnabled = false
        
        let completion: () -> Void = { [weak self] in
            self?.backgroundView.isHidden = true
        }
        
        self.avatarDecreasing(completion: completion)
    }
    
    private func avatarIncreasing() {
        
        avatarCenterStart = self.avatarImageView.center
        avatarBoundsStart = self.avatarImageView.bounds
       
        UIView.animate(withDuration: 0.5,
            animations: {

                self.avatarImageView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY)
                self.avatarImageView.transform = CGAffineTransform(scaleX: 1.001, y: 1.001)
                self.avatarImageView.bounds.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)

                self.avatarImageView.layer.cornerRadius = 0
                self.backgroundView.alpha = 0.8
                self.backgroundView.isHidden = false
            }
            , completion: { _ in
                UIView.animate(withDuration: 0.3,
                    animations: {
                        self.button.alpha = 1
                        self.button.isHidden = false
                    }
                )
            }
        )
    }
    
    private func avatarDecreasing(completion: @escaping () -> Void) {
        
        UIView.animateKeyframes(withDuration: 0.8,
                                delay: 0,
                                options: .calculationModeLinear) {
            
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.4) {
                self.button.alpha = 0
                self.button.isHidden = true
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0.4,
                               relativeDuration: 0.24) { [self] in
                
                self.avatarImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.avatarImageView.bounds = self.avatarBoundsStart
                self.avatarImageView.center = self.avatarCenterStart
                self.avatarImageView.layer.cornerRadius = 50
                self.avatarImageView.alpha = 0.02
                self.backgroundView.alpha = 0
            }
        }
    }
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return ProfileHeaderView()
        }
        return nil
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
        return PostModel.posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotosTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
            
            let post = PostModel.posts[indexPath.row]
            let viewModel = PostTableViewCell.ViewModel(
                author: post.author,
                image: post.image,
                description: post.description,
                views: post.views,
                likes: post.likes
            )
            cell.setup(with: viewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
          return 238
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
                let vc = PhotosViewController()
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}




