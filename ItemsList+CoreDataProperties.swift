//
//  ItemsList+CoreDataProperties.swift
//  
//
//  Created by Ghoost on 5/23/19.
//
//

import Foundation
import CoreData


extension ItemsList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemsList> {
        return NSFetchRequest<ItemsList>(entityName: "ItemsList")
    }

    @NSManaged public var img: String?
    @NSManaged public var left_amount: Int32
    @NSManaged public var left_axis: Double
    @NSManaged public var left_degree: Double
    @NSManaged public var left_deviation: Double
    @NSManaged public var name_ar: String?
    @NSManaged public var name_en: String?
    @NSManaged public var orPrice: Double
    @NSManaged public var product_id: Int32
    @NSManaged public var quantity: Int32
    @NSManaged public var right_amount: Int32
    @NSManaged public var right_axis: Double
    @NSManaged public var right_degree: Double
    @NSManaged public var right_deviation: Double
    @NSManaged public var similar: Int32
    @NSManaged public var total: Double
    @NSManaged public var type: Int32
    @NSManaged public var hasSize: Int32
    @NSManaged public var orAmount: Int32
    @NSManaged public var orRightAmount: Int32
    @NSManaged public var orLeftAmount: Int32
    @NSManaged public var sameSize: Bool


}
