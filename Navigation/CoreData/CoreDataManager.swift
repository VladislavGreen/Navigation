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

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addPost(
        author: String,
        description: String,
        imageData: Data?,
        views: Int64,
        likes: Int64
    ) {
        if checkIfItemExist(postDescription: description) == true {
            print("Такой пост уже есть")
            return
        } else {
            let post = PostCore(context: persistentContainer.viewContext)
            post.postAuthor = author
            post.postDescription = description
            post.postImageData = imageData
            post.postViews = views
            post.postLikes = likes
            
            saveContext()
            reloadPosts()
        }
    }
    
    func reloadPosts() {
        let fetchRequest = PostCore.fetchRequest()
        do {
            let postsCoreFetched = try persistentContainer.viewContext.fetch(fetchRequest)
            postsCore = postsCoreFetched
        } catch {
            print(error.localizedDescription)
            postsCore = []
        }
    }
    
    func checkIfItemExist(postDescription: String) -> Bool {
        
        let fetchRequest = PostCore.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "postDescription == %@" ,postDescription)
        
        do {
            let postsCoreFetched = try persistentContainer.viewContext.fetch(fetchRequest)
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
    
    func clearPosts() {
        let context = persistentContainer.viewContext
        for post in postsCore {
            context.delete(post)
        }
        saveContext()
        reloadPosts()
    }
}
