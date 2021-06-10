//
//  UserGeo+CoreDataProperties.swift
//  PostLists
//
//  Created by Sachin Patoliya on 10/06/21.
//
//

import Foundation
import CoreData


extension UserGeo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserGeo> {
        return NSFetchRequest<UserGeo>(entityName: "UserGeo")
    }

    @NSManaged public var id: Int16
    @NSManaged public var lat: String?
    @NSManaged public var lng: String?
}

extension UserGeo : Identifiable {

}
