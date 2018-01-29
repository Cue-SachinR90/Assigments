  //
  //  HomeTabController.swift
  //  Assignment1
  //
  //  Created by Sachin Rao on 16/01/18.
  //  Copyright © 2018 Cuelogic Technologies. All rights reserved.
  //
  
  import UIKit
  import CoreData
  
  protocol ProductFetchedDelegate {
    /// called when product fetched 
    func onProductFetch()
  }
  
  //Home Screen Controllers
  class HomeTabController: UITabBarController {
    
    var productDao:ProductDao = ProductDao()
    let serviceProvider = ServiceProvider()
    var productFetchedDelegate:ProductFetchedDelegate?
    
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
        //create Product Objects
        fetchProducts()
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
    
    func fetchProducts(){
        if(UIUtils.isConnectedToNetwork()){
            UIUtils.showLoader(self, strTitle: "Loading Data", strMessage: "Please wait...")
            serviceProvider.getProductData(fromUrl: Constants.get_products_url, sessionResultDelegate: self)
        }
    }
  }
  
  extension HomeTabController: SessionResult{
    func onSuccess(data: Data?, response: URLResponse?) {
        
        do{
            let databaseManagerInstance = DatabaseManager.shared;
            let context = databaseManagerInstance.context
            let decoder = JSONDecoder()
            
            //we'll get the value from another context using a fetch request later...
            let processedData = try decoder.decode(ProductResponse.self, from: data!)
            for product in processedData.products!{
                print(product.productname!)
                if productDao.fetchProductByName(product.productname!) == nil{
                    let prodItem = Product(entity: Product.entity(), insertInto: context)
                    prodItem.phoneNumber = product.phoneNumber!
                    prodItem.productname = product.productname!
                    prodItem.vendorname = product.vendorname!
                    prodItem.price = Double(product.price!)!
                    prodItem.vendoraddress = product.vendoraddress
                    databaseManagerInstance.saveContext()
                }
            }
            productFetchedDelegate?.onProductFetch()
        }catch let error as NSError  {
            print(error)
        }
        UIUtils.hideLoader()
    }
    
    func onFailure(error: Error?) {
        UIUtils.hideLoader()
        UIUtils.showOKAlert(self, strTitle: "Opps...", strMessage: "Something went wrong", actionButtonText: "OK", execFunc: nil)
    }
  }
  /*
   
   productDao.fetchProductByName(productName) == nil{
   product = Product(entity: Product.entity(), insertInto: context)
   product.productname = "Product \(i)"
   product.vendorname = "Vendor \(i)"
   product.price = Double(i * 1000)
   product.vendoraddress = "Location \(i)"
   databaseManagerInstance.saveContext()
   
   */
