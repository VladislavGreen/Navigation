//
//  SecondTabViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController, UINavigationBarDelegate {
    
    public var user: User = userDefault
    
    let postTableViewCell = PostTableViewCell()
    
    private let dataSource = Photo.photos
    
    
    private lazy var avatarImageView: UIImageView = {
        let profilePic = UIImageView()
        let picture = user.userAvatar
        profilePic.image = picture
        profilePic.isUserInteractionEnabled = true
        profilePic.alpha = 0.02
        profilePic.translatesAutoresizingMaskIntoConstraints = false
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
        view.translatesAutoresizingMaskIntoConstraints = false
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
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        
        #if DEBUG
            tableView.backgroundColor = .red
        #else
            tableView.backgroundColor = .systemBackground
        #endif
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.backgroundView)
        self.view.addSubview(self.button)
        self.view.addSubview(self.avatarImageView)
        self.roundingUIView(aView: avatarImageView, cornerRadiusParam: 50)
        
        NSLayoutConstraint.activate([
            
            self.avatarImageView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            self.avatarImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            self.avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            
            self.backgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.backgroundView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.backgroundView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.backgroundView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            self.button.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40),
            self.button.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.button.heightAnchor.constraint(equalToConstant: 64),
            self.button.widthAnchor.constraint(equalToConstant: 64),
            
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ].compactMap({ $0 }))
    }
    
    func roundingUIView(aView: UIView!, cornerRadiusParam: CGFloat!) {
           aView.clipsToBounds = true
           aView.layer.cornerRadius = cornerRadiusParam
       }
    
    private func setupGestures() {
        
        let tapGestureRecognizerAvatar = UITapGestureRecognizer(
            target: self,
            action: #selector(self.handleTapGestureAvatar(_:)))
        tapGestureRecognizerAvatar.numberOfTapsRequired = 2
        self.avatarImageView.addGestureRecognizer(tapGestureRecognizerAvatar)
        
        let tapGestureRecognizerCell = UITapGestureRecognizer(
            target: self,
            action: #selector(self.handleTapGestureCell(_:)))
        tapGestureRecognizerCell.numberOfTapsRequired = 2
        tapGestureRecognizerCell.cancelsTouchesInView = false
        self.tableView.addGestureRecognizer(tapGestureRecognizerCell)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc private func handleTapGestureAvatar(_ gestureRecognizer: UITapGestureRecognizer) -> () {
        self.button.isEnabled = true
        self.avatarImageView.alpha = 1
        self.avatarIncreasing()
        
        CoreDataManager.coreDataManager.clearPosts()
//        tableView.reloadData()
    }
    
    @objc private func handleTapGestureCell(_ gestureRecognizer: UITapGestureRecognizer) -> () {
        let tapLocation = gestureRecognizer.location(in: self.tableView)
        
        if let tapIndexPath = self.tableView.indexPathForRow(at: tapLocation) {
            if self.tableView.cellForRow(at: tapIndexPath) is PostTableViewCell {
                    
                let post = PostModel.posts[tapIndexPath.row]
                
                let jpegImageData = post.image?.jpegData(compressionQuality: 1.0)
                
                CoreDataManager.coreDataManager.addPost(
                    id: post.id,
                    author: post.author,
                    description: post.description,
                    imageData: jpegImageData,
                    views: Int64(post.views),
                    likes: Int64(post.likes)
                )
                tableView.reloadData()
            }
        }
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
        guard section == 0 else { return nil }
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as? ProfileHeaderView {
            view.setUserDetails(user)
            return view
        } else {
            preconditionFailure("user do not exist")
        }
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
        }
        
        if indexPath.section == 1, self.tabBarController?.selectedIndex == 1  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
            
            let post = PostModel.posts[indexPath.row]
            let viewModel = PostTableViewCell.ViewModel(
                id: post.id,
                author: post.author,
                image: post.image,
                description: post.description,
                views: post.views,
                likes: post.likes
            )
            cell.setup(with: viewModel)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
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


extension ProfileViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

