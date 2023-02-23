//
//  FavouritesTVController.swift
//  Navigation
//
//  Created by Vladislav Green on 12/20/22.
//

import UIKit
import CoreData

class FavouritesTVController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    private enum LocalizedKeys: String {
//        case title = "FavouritesTVC-status" // "Favourites"
        case filterName = "FavouritesTVC-filterName" // "Filter by Author"
        case reset = "FavouritesTVC-reset" // "Reset Filter"
    }
    
    var fetchedResultsController: NSFetchedResultsController<PostCore>?
    
    
    func initFetchedResultsController() {
        
        let fetchRequest = PostCore.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "postID", ascending: true)]
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataManager.coreDataManager.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = frc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        
        initFetchedResultsController()
        fetchedResultsController?.delegate = self
        try? fetchedResultsController?.performFetch()
    }
    
    
    func setupNavigationBar() {
        navigationItem.title = "FavouritesTVC-status".localized
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "FavouritesTVC-filterName".localized,
            style: .plain,
            target: self,
            action: #selector(filterPostsByAuthor))
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "FavouritesTVC-reset".localized,
            style: .plain,
            target: self,
            action: #selector(resetPostsFilter))
    }
    
    
    @objc
    func filterPostsByAuthor() {
        
        TextPicker.defaultPicker.showPicker(in: self) { text in
            
            let predicate = NSPredicate(format: "postAuthor CONTAINS %@", text)
            self.fetchedResultsController?.fetchRequest.predicate = predicate
            
            do {
                try self.fetchedResultsController?.performFetch()
                self.tableView.reloadData()
            } catch let error as NSError {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    @objc
    func resetPostsFilter() {
        
        self.fetchedResultsController?.fetchRequest.predicate = nil
        
        do {
            try self.fetchedResultsController?.performFetch()
            self.tableView.reloadData()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController?.sections?[0].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        
        let post = fetchedResultsController?.object(at: indexPath)
        
        let emptyPostImage = UIImage(systemName: "person")
        let emptyPostImageData = emptyPostImage?.jpegData(compressionQuality: 1.0)
        
        let image = UIImage(data: (post?.postImageData ?? emptyPostImageData)!)
            
        let viewModel = PostTableViewCell.ViewModel(
            id: post!.postID,
            author: post?.postAuthor ?? "No data".localized,
            image: image,
            description: post?.postDescription ?? "No data".localized,
            views: Int(post!.postViews),
            likes: Int(post!.postLikes)
        )
        cell.setup(with: viewModel)

        return cell
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .insert:
            guard let newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            tableView.reloadData()
        case .update:
            guard let indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            print("Somethig went wrong")
        }
    }
    

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if let post = fetchedResultsController?.object(at: indexPath) {
                let postID = post.postID
                CoreDataManager.coreDataManager.clearPost(post: post, with: postID)
            }
        }
    }
}
