//
//  HomeTabController.swift
//  Assignment1
//
//  Created by Sachin Rao on 16/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import UIKit
import CoreData

//Home Screen Controllers
class HomeTabController: UITabBarController {
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    var cartList = [Product]()
    func attachLogoutButton(title: String) {
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: title,
                                          style: UIBarButtonItemStyle.plain, target: self,
                                            action: #selector(self.performLogOut))
        self.navigationItem.leftBarButtonItem = newBackButton
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        attachLogoutButton(title: "LogOut")
        //clear first products data
        deleteAllDataFromProducts(entity: "Product")
        
        //create Product Objects
        genereateProductList()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func performLogOut(){
        UIUtils.showCancelableAlert(self, strTitle: "Logout?", strMessage: "Are you sure you want to logout?", positiveButtonText: "Yes", negativeButtonText: "No", positiveButtonAction: {
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.popViewController(animated: true)
        }, negativeButtonAction: nil)
    }
    
    //MARK:- Metohds
    
    private func deleteAllDataFromProducts(entity: String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do
        {
            let results = try context.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }
    
    
    func genereateProductList(){
        var product : Product!
        //create 10 products
        
        for i in 1...10{
            product = Product(entity: Product.entity(), insertInto: context)
            product.productID = Int16(i)
            product.productName = "Product \(i)"
            product.vendorName = "Vendor \(i)"
            product.productPrice = Double(i * 1000)
            product.vendorAddress = "Location \(i)"
            appDelegate.saveContext()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
