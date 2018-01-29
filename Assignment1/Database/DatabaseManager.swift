//
//  DatabaseManager.swift
//  Assignment1
//
//  Created by Sachin Nagraj Rao on 28/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import Foundation
import CoreData

public class DatabaseManager{
    
   static let shared = DatabaseManager()

    private init(){
        
    }
    
    //create PersistentContainer
    lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AssignmentCoreData")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Unresolved Error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    //MARK: METHODS
    func saveContext(){
        let context = persistentContainer.viewContext
        if  context.hasChanges{
            do{
                try context.save()
            }catch{
                let error = error as NSError
                fatalError("Unresolved Error \(error), \(error.userInfo)")
            }
        }
    }
    func reset(){
        let context = persistentContainer.viewContext
        if(context.hasChanges){
            context.reset()
        }
    }
}
