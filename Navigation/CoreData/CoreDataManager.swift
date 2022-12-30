//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Vladislav Green on 12/16/22.
//

import CoreData

class CoreDataManager {
    
    static let coreDataManager = CoreDataManager()

    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Navigation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
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
        id: Int64,
        author: String,
        description: String,
        imageData: Data?,
        views: Int64,
        likes: Int64
    ) {
        persistentContainer.performBackgroundTask { context in
            
            if self.checkIfItemExist(postID: id, context: context) == true {
                print("Такой пост уже есть")
                return
            } else {
                let post = PostCore(context: context)
                post.postID = id
                post.postAuthor = author
                post.postDescription = description
                post.postImageData = imageData
                post.postViews = views
                post.postLikes = likes
                
                try? context.save()
            }
        }
    }
    
    
    func checkIfItemExist(postID: Int64, context: NSManagedObjectContext) -> Bool {
        
        let fetchRequest = PostCore.fetchRequest()
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "postID == %i", postID)
        
        do {
            let postsCoreFetched = try context.fetch(fetchRequest)
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
    
    
    func clearPost(post: PostCore, with id: Int64) {
        
        persistentContainer.viewContext.delete(post)
        saveContext()
    }
    
    
    func clearPosts() {
        
        let fetchRequest = PostCore.fetchRequest()
        for post in (try? persistentContainer.viewContext.fetch(fetchRequest)) ?? [] {
            clearPost(post: post, with: post.postID)
        }
        saveContext()
    }
}
