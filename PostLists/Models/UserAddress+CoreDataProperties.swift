//
//  UserAddress+CoreDataProperties.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//
//

import Foundation
import CoreData


extension UserAddress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserAddress> {
        return NSFetchRequest<UserAddress>(entityName: "UserAddress")
    }

    @NSManaged public var city: String?
    @NSManaged public var id: Int16
    @NSManaged public var street: String?
    @NSManaged public var suite: String?
    @NSManaged public var zipcode: String?

}

extension UserAddress : Identifiable {

}
