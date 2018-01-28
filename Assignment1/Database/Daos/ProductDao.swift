//
//  ProductDao.swift
//  Assignment1
//
//  Created by Sachin Nagraj Rao on 28/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import Foundation
import CoreData
public class ProductDao{
    
    
    public func deleteAllDataFromProducts(){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try DatabaseManager.shared.context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                DatabaseManager.shared.context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \("Product") error : \(error) \(error.userInfo)")
        }
    }
    
    public func fetchProductByName(_ name:String) -> Product? {
        let managedContext = DatabaseManager.shared.context;
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Product")
        let predicate = NSPredicate(format: "productname == '\(name)'")
        fetchRequest.predicate = predicate
        do{
            let fetchedObject = try managedContext.fetch(fetchRequest)
            if fetchedObject.count > 0{
                let product = fetchedObject[0] as! Product
                return product
            }
        }catch{
            
        }
        return nil
    }
}
