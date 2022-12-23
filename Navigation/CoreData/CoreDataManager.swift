//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Vladislav Green on 12/16/22.
//

import CoreData

class CoreDataManager {
    
    static let coreDataManager = CoreDataManager()
    
    var postsCore: [PostCore] = []
    
    // Переменная для временного хранения Избранного
    var postsCoreFavourites:  [PostCore] = []
    
    init() {
        reloadPosts()
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()
    
    lazy var foregroundContext: NSManagedObjectContext = {
        var context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        return context
    }()

    // MARK: - Core Data Saving support

//    func saveContext () {
//        let context = persistentContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }
    
    func addPost(
        id: Int64,
        author: String,
        description: String,
        imageData: Data?,
        views: Int64,
        likes: Int64
    ) {
        backgroundContext.perform {
            if self.checkIfItemExist(postID: id) == true {
                print("Такой пост уже есть")
                return
            } else {
                let post = PostCore(context: self.backgroundContext)
                post.postID = id
                post.postAuthor = author
                post.postDescription = description
                post.postImageData = imageData
                post.postViews = views
                post.postLikes = likes
                
                try? self.backgroundContext.save()
                self.postsCoreFavourites.append(post)
                self.reloadPosts()
            }
        }
    }
    
    func reloadPosts() {
        let fetchRequest = PostCore.fetchRequest()
        do {
            let postsCoreFetched = try foregroundContext.fetch(fetchRequest)
            postsCore = postsCoreFetched
        } catch {
            print(error.localizedDescription)
            postsCore = []
        }
    }
    
    func checkIfItemExist(postID: Int64) -> Bool {
        
        let fetchRequest = PostCore.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "postID == %i", postID)
        
        do {
            let postsCoreFetched = try backgroundContext.fetch(fetchRequest)
            if postsCoreFetched.count > 0 {
                return true
            } else {
                return false
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    
    func getPostsByAuthor(author: String, completion: ()->()) {
        
        let fetchRequest = PostCore.fetchRequest()
        if author != "" {
            fetchRequest.predicate = NSPredicate(format: "postAuthor CONTAINS %@", author)
        }
        let postsFetched = (try? backgroundContext.fetch(fetchRequest)) ?? []
        for postFetched in postsFetched {
            let post = PostCore(context: backgroundContext)
            post.postID = postFetched.postID
            post.postAuthor = postFetched.postAuthor
            post.postDescription = postFetched.postDescription
            post.postImageData = postFetched.postImageData
            post.postViews = postFetched.postViews
            post.postLikes = postFetched.postLikes
        }
        clearPosts()
        try? self.backgroundContext.save()
        reloadPosts()
        completion()
    }
    
    
    func getUnfilteredPostsBack(completion: ()->()) {
        clearPosts()
        for post in postsCoreFavourites {
            let postToRestore = PostCore(context: backgroundContext)
            postToRestore.postID = post.postID
            postToRestore.postAuthor = post.postAuthor
            postToRestore.postDescription = post.postDescription
            postToRestore.postImageData = post.postImageData
            postToRestore.postViews = post.postViews
            postToRestore.postLikes = post.postLikes
        }
        try? self.backgroundContext.save()
        self.reloadPosts()
//        postsCoreFavourites = []
        completion()
    }
    
    
    func clearPost(with id: Int64) {
        
        let fetchRequest = PostCore.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "postID == %i", id)
        
        do {
            let postsCoreFetched = try foregroundContext.fetch(fetchRequest)
            foregroundContext.delete(postsCoreFetched.first!)
            
            try? self.foregroundContext.save()
            reloadPosts()
        } catch {
            print(error.localizedDescription)
        }
        
        let postsCashed = postsCoreFavourites
        for post in postsCashed {
            if post.postID == id {
                postsCoreFavourites = postsCashed.filter { $0 != post }
            }
        }
    }
    
    
    func clearPosts() {
        let context = foregroundContext
        for post in postsCore {
            context.delete(post)
        }
        try? self.foregroundContext.save()
        reloadPosts()
    }
}
