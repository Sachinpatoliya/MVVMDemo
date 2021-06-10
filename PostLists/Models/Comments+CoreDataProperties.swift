//
//  Comments+CoreDataProperties.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//
//

import Foundation
import CoreData


extension Comments {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comments> {
        return NSFetchRequest<Comments>(entityName: "Comments")
    }

    @NSManaged public var body: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var postId: Int16

}

extension Comments : Identifiable {

}
