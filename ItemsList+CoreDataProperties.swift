//
//  ItemsList+CoreDataProperties.swift
//  
//
//  Created by mahmoudhajar on 2/25/19.
//
//

import Foundation
import CoreData


extension ItemsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemsList> {
        return NSFetchRequest<ItemsList>(entityName: "ItemsList")
    }

    @NSManaged public var left_amount: Int16
    @NSManaged public var left_degree: Int16
    @NSManaged public var package: Int16
    @NSManaged public var product_id: Int16
    @NSManaged public var quantity: Int16
    @NSManaged public var right_amount: Int16
    @NSManaged public var right_degree: Int16
    @NSManaged public var similar: Int16
    @NSManaged public var total: Int16
    @NSManaged public var product: Product?

}
