//
//  Cart+CoreDataProperties.swift
//  Assignment1
//
//  Created by Sachin Rao on 24/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var cartProduct: Product?

}
