//
//  Cart+CoreDataProperties.swift
//  Assignment1
//
//  Created by Sachin Nagraj Rao on 28/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var phoneNumber: String?
    @NSManaged public var productImg: String?
    @NSManaged public var vendoraddress: String?
    @NSManaged public var vendorname: String?
    @NSManaged public var price: Double
    @NSManaged public var productname: String?
    @NSManaged public var quantity: Int32

}
