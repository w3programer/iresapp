//
//  Product+CoreDataProperties.swift
//  
//
//  Created by mahmoudhajar on 2/25/19.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var token: String?
    @NSManaged public var total: Int16
    @NSManaged public var itemList: NSSet?

}

// MARK: Generated accessors for itemList
extension Product {

    @objc(addItemListObject:)
    @NSManaged public func addToItemList(_ value: ItemsList)

    @objc(removeItemListObject:)
    @NSManaged public func removeFromItemList(_ value: ItemsList)

    @objc(addItemList:)
    @NSManaged public func addToItemList(_ values: NSSet)

    @objc(removeItemList:)
    @NSManaged public func removeFromItemList(_ values: NSSet)

}
