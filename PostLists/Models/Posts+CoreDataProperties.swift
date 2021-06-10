//
//  Posts+CoreDataProperties.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//
//

import Foundation
import CoreData


extension Posts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Posts> {
        return NSFetchRequest<Posts>(entityName: "Posts")
    }

    @NSManaged public var body: String?
    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var userId: Int16

}

extension Posts : Identifiable {

}
