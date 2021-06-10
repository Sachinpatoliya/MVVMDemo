//
//  UserCompany+CoreDataProperties.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//
//

import Foundation
import CoreData


extension UserCompany {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCompany> {
        return NSFetchRequest<UserCompany>(entityName: "UserCompany")
    }

    @NSManaged public var bs: String?
    @NSManaged public var catchPhrase: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?

}

extension UserCompany : Identifiable {

}
