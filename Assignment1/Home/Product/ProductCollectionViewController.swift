//
//  ProductCollectionViewController.swift
//  Assignment1
//
//  Created by Sachin Rao on 17/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import UIKit
import CoreData

class ProductCollectionViewController: UICollectionViewController {
    var listOfProduct:[Product] = [Product]()
    var cartDao = CartDao()
    @IBOutlet var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
        //fetch product from core data
        
        fetchData()
        
        //calculate the width of the collection view
        let width = (view.frame.size.width - 30) / 2
        let height = (view.frame.size.height) / 1.8
        
        let layout = productCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:- private methods
    
    /// this method is used to fetch
    
    private func fetchData(){
        
        do{
            listOfProduct = try DatabaseManager.shared.context.fetch(Product.fetchRequest())
        }catch let error as NSError{
            fatalError("Unresolved Error \(error),\(error.userInfo)")
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return listOfProduct.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = listOfProduct[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as! ProductCollectionViewCell
        // Configure the cell
        
        cell.productNameLabel.text = product.productname
        
        cell.vendorNameLabel.text = product.vendorname
        
        cell.priceNameLabel.text = "\u{20B9} \(product.price)"
        
        cell.addToCartButtonCell.tag = indexPath.row
        
        cell.addCartDelegate = self
        
        return cell
    }
    
}
extension ProductCollectionViewController:AddToCartDelegate{
    func addToCart(index: Int) {
        let product = listOfProduct[index]
        // TODO: add to cart
        if let cartItem = cartDao.fetchCartByName(product.productname!){// update cartquantity
            let quantity = cartItem.quantity + 1 ;
            cartDao.updateCartQuantity(cartItem.productname!, quantity)
        }else{
            //insert cart
            let databaseManagerInstance = DatabaseManager.shared;
            let context = databaseManagerInstance.context
            let cartItem = Cart(entity: Cart.entity(), insertInto: context)
            cartItem.productname =  product.productname!
            cartItem.vendorname = product.vendorname!
            cartItem.price = product.price
            cartItem.total = product.price
            cartItem.vendoraddress = product.vendoraddress!
            cartItem.quantity = 1
            databaseManagerInstance.saveContext()
        }
    }
}



//    // MARK: UICollectionViewDelegate
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//    }
/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
 return true
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
 return false
 }
 
 override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
 
 }
 */
