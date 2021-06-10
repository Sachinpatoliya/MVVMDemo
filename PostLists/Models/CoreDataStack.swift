//
//  CoreDataStack.swift
//  PracticalTask
//
//  Created by Nikunj on 19/03/21.
//  Copyright © 2021 Nikunj. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataStack: NSObject {
    
    static let sharedInstance = CoreDataStack()
    private override init() {}
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PostLists")
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
}

extension CoreDataStack {
    func applicationDocumentsDirectory() {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "yo.BlogReaderApp" in the application's documents directory.
        if let url = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last {
            print(url.absoluteString)
        }
    }
}

//MARK:- Posts
func saveInCoreDataWith(array: [[String: AnyObject]], completion:(([Posts]) -> ())?) {
    let posts = array.map{addPostsEntityFrom(dictionary: $0)}
    do {
        try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        completion?(posts as? [Posts] ?? [])
    } catch let error {
        print(error)
        completion?([])
    }
}

func addPostsEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    if let postEntity = NSEntityDescription.insertNewObject(forEntityName: CoredataEntityNames.Posts, into: context) as? Posts {
        postEntity.userId = dictionary["userId"] as? Int16 ?? 0
        postEntity.id = dictionary["id"] as? Int16 ?? 0
        postEntity.title = dictionary["title"] as? String ?? ""
        postEntity.body = dictionary["body"] as? String ?? ""
        return postEntity
    }
    return nil
}

var fetchedPosts: [Posts] = {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Posts.self))
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext

    do {
        
        let results   = try context.fetch(fetchRequest)
        let postsList = results as! [Posts]
        
        return postsList
    } catch let error as NSError {
        print("Could not fetch \(error)")
    }

    return []
}()



//MARK:- Save User Listings to Coredata
func saveUsersInCoreDataWith(array: [[String: AnyObject]], completion:(([Users]) -> ())?) {
    let users = array.map{addUsersEntityFrom(dictionary: $0)}
    do {
        try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        completion?(users as? [Users] ?? [])
    } catch let error {
        print(error)
        completion?([])
    }
}

func addUsersEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    if let userEntity = NSEntityDescription.insertNewObject(forEntityName: CoredataEntityNames.Users, into: context) as? Users {
        userEntity.id = dictionary["id"] as? Int16 ?? 0
        userEntity.name = dictionary["name"] as? String ?? ""
        userEntity.username = dictionary["username"] as? String ?? ""
        userEntity.email = dictionary["email"] as? String ?? ""
        userEntity.phone = dictionary["phone"] as? String ?? ""
        userEntity.website = dictionary["website"] as? String ?? ""
        saveUsersAddressInCoreDataWith(data: dictionary["address"] as? [String: AnyObject] ?? [:] , userID: dictionary["id"] as? Int16 ?? 0)
        saveUsersCompanyInCoreDataWith(data: dictionary["company"] as? [String: AnyObject] ?? [:] , userID: dictionary["id"] as? Int16 ?? 0)
        return userEntity
    }
    return nil
}

func fetchUser(userID: Int16, completion:((Users) -> ())?){
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Users.self))
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
    do {
        let predicate = NSPredicate(format: "id = %d", userID);
        
        fetchRequest.predicate = predicate

        let results   = try context.fetch(fetchRequest)
        let user = results as! [Users]
        if user.count > 0{
            completion?(user.first!)
        }
    } catch let error as NSError {
        print("Could not fetch \(error)")
    }
}

//MARK:- Save User Address to Coredata
func saveUsersAddressInCoreDataWith(data: [String: AnyObject], userID: Int16) {
    _ = addUsersAddressEntityFrom(dictionary: data, userId: userID)
    do {
        try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
    } catch let error {
        print(error)
    }
}

func addUsersAddressEntityFrom(dictionary: [String: AnyObject], userId: Int16) -> NSManagedObject? {
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    if let userAddressEntity = NSEntityDescription.insertNewObject(forEntityName: CoredataEntityNames.UserAddress, into: context) as? UserAddress {
        userAddressEntity.id = userId
        userAddressEntity.street = dictionary["street"] as? String ?? ""
        userAddressEntity.suite = dictionary["suite"] as? String ?? ""
        userAddressEntity.city = dictionary["city"] as? String ?? ""
        userAddressEntity.zipcode = dictionary["zipcode"] as? String ?? ""
        saveUsersAddressGeoInCoreDataWith(data: dictionary["geo"] as? [String: AnyObject] ?? [:] , userID: userId)
        
        return userAddressEntity
    }
    return nil
}

func fetchUserAddress(userID: Int16, completion:((UserAddress) -> ())?){
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: UserAddress.self))
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
    do {
        let predicate = NSPredicate(format: "id = %d", userID);
        
        fetchRequest.predicate = predicate
        
        let results   = try context.fetch(fetchRequest)
        let user = results as! [UserAddress]
        if user.count > 0{
            completion?(user.first!)
        }
    } catch let error as NSError {
        print("Could not fetch \(error)")
    }
}

//MARK:- Save User Address Geo Location to Coredata
func saveUsersAddressGeoInCoreDataWith(data: [String: AnyObject], userID: Int16) {
    _ = addUsersAddressGeoEntityFrom(dictionary: data, userId: userID)
    do {
        try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
    } catch let error {
        print(error)
    }
}

func addUsersAddressGeoEntityFrom(dictionary: [String: AnyObject], userId: Int16) -> NSManagedObject? {
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    if let userAddressGeoEntity = NSEntityDescription.insertNewObject(forEntityName: CoredataEntityNames.UserGeo, into: context) as? UserGeo {
        userAddressGeoEntity.id = userId
        userAddressGeoEntity.lat = dictionary["lat"] as? String ?? ""
        userAddressGeoEntity.lng = dictionary["lng"] as? String ?? ""
        return userAddressGeoEntity
    }
    return nil
}

func fetchUserAddressGeo(userID: Int16, completion:((UserGeo) -> ())?){
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: UserGeo.self))
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
    do {
        let predicate = NSPredicate(format: "id = %d", userID);
        
        fetchRequest.predicate = predicate
        
        let results   = try context.fetch(fetchRequest)
        let user = results as! [UserGeo]
        if user.count > 0{
            completion?(user.first!)
        }
    } catch let error as NSError {
        print("Could not fetch \(error)")
    }
}

//MARK:- Save User Company to Coredata
func saveUsersCompanyInCoreDataWith(data: [String: AnyObject], userID: Int16) {
    _ = addUsersCompanyEntityFrom(dictionary: data, userId: userID)
    do {
        try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
    } catch let error {
        print(error)
    }
}

func addUsersCompanyEntityFrom(dictionary: [String: AnyObject], userId: Int16) -> NSManagedObject? {
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    if let userCompany = NSEntityDescription.insertNewObject(forEntityName: CoredataEntityNames.UserCompany, into: context) as? UserCompany {
        userCompany.id = userId
        userCompany.name = dictionary["name"] as? String ?? ""
        userCompany.catchPhrase = dictionary["catchPhrase"] as? String ?? ""
        userCompany.bs = dictionary["bs"] as? String ?? ""

        return userCompany
    }
    return nil
}


func fetchUserCompany(userID: Int16, completion:((UserCompany) -> ())?){
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: UserCompany.self))
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
    do {
        let predicate = NSPredicate(format: "id = %d", userID);
        
        fetchRequest.predicate = predicate
        
        let results   = try context.fetch(fetchRequest)
        let user = results as! [UserCompany]
        if user.count > 0{
            completion?(user.first!)
        }
    } catch let error as NSError {
        print("Could not fetch \(error)")
    }
}


//MARK:- Fetch Comment Lists
func saveCommentsInCoreDataWith(array: [[String: AnyObject]], completion:(([Comments]) -> ())?) {
    let comments = array.map{addCommentsEntityFrom(dictionary: $0)}
    do {
        try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        completion?(comments as! [Comments])
    } catch let error {
        print(error)
        completion?([])
    }
}

func addCommentsEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    if let commentEntity = NSEntityDescription.insertNewObject(forEntityName: CoredataEntityNames.Comments, into: context) as? Comments {
        commentEntity.postId = dictionary["postId"] as? Int16 ?? 0
        commentEntity.id = dictionary["id"] as? Int16 ?? 0
        commentEntity.name = dictionary["name"] as? String ?? ""
        commentEntity.email = dictionary["email"] as? String ?? ""
        commentEntity.body = dictionary["body"] as? String ?? ""
        return commentEntity
    }
    return nil
}

func fetchComments(postId: Int16, completion:(([Comments]) -> ())?) {
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Comments.self))
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
    
    do {
        let predicate = NSPredicate(format: "postId = %d", postId);
        
        fetchRequest.predicate = predicate

        let results   = try context.fetch(fetchRequest)
        let postsList = results as! [Comments]
        
        completion?(postsList )
    } catch let error as NSError {
        print("Could not fetch \(error)")
        completion?([])
    }
}


//MARK:- Clear all Entities
func clearUserData(){
    clearCoredata(entityName: CoredataEntityNames.UserAddress)
    clearCoredata(entityName: CoredataEntityNames.UserGeo)
    clearCoredata(entityName: CoredataEntityNames.Users)
    clearCoredata(entityName: CoredataEntityNames.UserCompany)
}

func clearCoredata(entityName: String) {
    // Initialize Fetch Request
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    let context = CoreDataStack.sharedInstance.persistentContainer.viewContext

    // Configure Fetch Request
    fetchRequest.includesPropertyValues = false
    
    do {
        let items = try context.fetch(fetchRequest) as! [NSManagedObject]
        
        for item in items {
            context.delete(item)
        }
        
        try context.save()
        
    } catch {
    }
}
