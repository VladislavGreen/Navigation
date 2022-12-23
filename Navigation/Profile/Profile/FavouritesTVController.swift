//
//  FavouritesTVController.swift
//  Navigation
//
//  Created by Vladislav Green on 12/20/22.
//

import UIKit

class FavouritesTVController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Favourites"
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Filter by Author",
            style: .plain,
            target: self,
            action: #selector(filterPostsByAuthor))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Reset Filter",
            style: .plain,
            target: self,
            action: #selector(resetPostsFilter))
    }
    
    @objc
    func filterPostsByAuthor() {
        TextPicker.defaultPicker.showPicker(in: self) { text in
            print(text)
            CoreDataManager.coreDataManager.getPostsByAuthor(author: text) {
                self.tableView.reloadData()
            }
        }
    }
    
    
    @objc
    func resetPostsFilter() {
        CoreDataManager.coreDataManager.getUnfilteredPostsBack() {
            self.tableView.reloadData()
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.coreDataManager.postsCore.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        let post = CoreDataManager.coreDataManager.postsCore[indexPath.row]
        
        let emptyPostImage = UIImage(systemName: "person")
        let emptyPostImageData = emptyPostImage?.jpegData(compressionQuality: 1.0)
        
        let image = UIImage(data: (post.postImageData ?? emptyPostImageData)!)
            
        let viewModel = PostTableViewCell.ViewModel(
            id: post.postID,
            author: post.postAuthor ?? "no data",
            image: image,
            description: post.postDescription ?? "no data",
            views: Int(post.postViews),
            likes: Int(post.postLikes)
        )
        cell.setup(with: viewModel)

        return cell
    }

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let item = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            let post = CoreDataManager.coreDataManager.postsCore[indexPath.row]
            let postID = post.postID
            
            CoreDataManager.coreDataManager.clearPost(with: postID)
            tableView.reloadData()
        }
        item.image = UIImage(named: "deleteIcon")
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        return swipeActions
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
