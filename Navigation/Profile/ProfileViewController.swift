//
//  SecondTabViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit

class ProfileViewController: UIViewController, UINavigationBarDelegate {
    
    let postTableViewCell = PostTableViewCell()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
        tableView.backgroundColor = .lightGray
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 528
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 524
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(self.tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
        ])
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
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PostModel.posts.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? PostTableViewCell
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        
        let post = PostModel.posts[indexPath.row]
        
        let viewModel = PostTableViewCell.ViewModel(
            author: post.author,
            image: post.image,
            description: post.description,
            views: post.views,
            likes: post.likes
        )
        cell.setup(with: viewModel)
        
        
//        var content = cell.defaultContentConfiguration()
//        content.text = postTableViewCell.postName.text
//        content.image = postTableViewCell.postImage.image
//        content.secondaryText = postTableViewCell.postText.text
//        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
          return 238
        } else {
            return UITableView.automaticDimension
        }
    }
}

