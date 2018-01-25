//
//  Product+CoreDataProperties.swift
//  Assignment1
//
//  Created by Sachin Rao on 23/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productID: Int16
    @NSManaged public var productName: String?
    @NSManaged public var productPrice: Double
    @NSManaged public var vendorAddress: String?
    @NSManaged public var vendorName: String?

}
