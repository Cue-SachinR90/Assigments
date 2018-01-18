//
//  ProductCollectionViewController.swift
//  Assignment1
//
//  Created by Sachin Rao on 17/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import UIKit

class ProductCollectionViewController: UICollectionViewController {
    var listOfProduct:[Product] = [Product]()
    @IBOutlet var productCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //fetch product from the plist
        fetchDataFromPList()
        
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
    
    /// this method is used to fetch array of dictionaries from the plist
    private func fetchDataFromPList(){
        //get url of the file where our product_list.plist is located
        let url = Bundle.main.path(forResource: "product_list", ofType: "plist")
        
        //get teh dictionary from the URL provided
        let productPListDictionary = NSDictionary(contentsOfFile: url!) as? [String : Array<Dictionary<String, Any>>]
        
        //get arrays of dictionary for the key named  products
        let arrayOfProducts = productPListDictionary!["products"]
        
        //remove all product from the plist 1st
        listOfProduct.removeAll()
        
        //iterate all product from the dictionary and append to the or list of product
        for item in arrayOfProducts! {
            let product = Product()
            product.name = item["productName"] as! String
            product.vendorName = item["vendorName"] as! String
            product.price = item["price"] as! Int
            listOfProduct.append(product)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

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
       
            cell.productNameLabel.text = product.name
        
            cell.vendorNameLabel.text = product.vendorName
        
            cell.priceNameLabel.text = "\u{20B9} \(product.price)"
        
            cell.addToCartButtonCell.tag = indexPath.row
        
            cell.addCartDelegate = self
        
        return cell
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

}
extension ProductCollectionViewController:AddToCartDelegate{
    func addToCart(index: Int) {
        let product = listOfProduct[index]
        //add to cart
        (self.tabBarController as! HomeTabController).cartList.append(product)
    }
}
