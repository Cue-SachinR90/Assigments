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
    
    var productDao:ProductDao = ProductDao()
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
        productDao.deleteAllDataFromProducts()
        
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
    
    func genereateProductList(){
        var product : Product!
        //create 10 products
        let databaseManagerInstance = DatabaseManager.shared;
        let context = databaseManagerInstance.context
        for i in 1...10{
            let productName = "Product \(i)";
            if productDao.fetchProductByName(productName) == nil{
                product = Product(entity: Product.entity(), insertInto: context)
                product.productname = "Product \(i)"
                product.vendorname = "Vendor \(i)"
                product.price = Double(i * 1000)
                product.vendoraddress = "Location \(i)"
                databaseManagerInstance.saveContext()
            }
        }
    }

}
