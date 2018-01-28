//
//  CartDao.swift
//  Assignment1
//
//  Created by Sachin Nagraj Rao on 28/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import Foundation
import CoreData

public class CartDao{
    
    
    public func fetchCartByName(_ name:String) -> Cart? {
        let managedContext = DatabaseManager.shared.context;
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Cart")
        let predicate = NSPredicate(format: "productname == '\(name)'")
        fetchRequest.predicate = predicate
        do{
            let fetchedObject = try managedContext.fetch(fetchRequest)
            if fetchedObject.count > 0{
                let cartItem = fetchedObject[0] as! Cart
                return cartItem
            }
        }catch{
            
        }
        return nil
    }
    
    public func updateCartQuantity(_ name:String, _ quantity:Int32){
        let managedContext = DatabaseManager.shared.context;
        let cartProduct =  fetchCartByName(name)
        cartProduct!.setValue(quantity, forKey: "quantity")
        cartProduct!.setValue(((cartProduct?.price)! * Double(quantity)), forKey: "total")
        do{
            try managedContext.save()
        }catch let error as NSError{
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
