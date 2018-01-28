//
//  Product+CoreDataProperties.swift
//  Assignment1
//
//  Created by Sachin Nagraj Rao on 28/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var productname: String?
    @NSManaged public var price: Double
    @NSManaged public var vendoraddress: String?
    @NSManaged public var vendorname: String?
    @NSManaged public var productImg: String?
    @NSManaged public var phoneNumber: String?

}
