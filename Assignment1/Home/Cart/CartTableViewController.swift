//
//  TableViewController.swift
//  Assignment1
//
//  Created by Sachin Rao on 17/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    
    var cartList:[Cart] = [Cart]()
    var cartDao = CartDao()
    @IBOutlet var cartTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        cartTableView.rowHeight = UITableViewAutomaticDimension
        cartTableView.estimatedRowHeight = 150
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    private func fetchData(){
        
        do{
            cartList = try DatabaseManager.shared.context.fetch(Cart.fetchRequest())
        }catch let error as NSError{
            fatalError("Unresolved Error \(error),\(error.userInfo)")
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cartList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        let cartItem = cartList[indexPath.row]
        cell.productNameLabel.text =  cartItem.productname
        cell.vendorNameLabel?.text = cartItem.vendorname
        cell.priceLabel?.text = "\u{20B9} \(cartItem.total)"
        cell.quantity?.text = "\(cartItem.quantity)"
        cell.removeCartButton.tag = indexPath.row
        cell.removeCartDelegate = self
        return cell
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension CartTableViewController:RemoveFromCarDelegate{
    func removeFromCart(index: Int) {
        let cartItem = cartList[index]
        if cartItem.quantity == 1{
            //delete
            let managedContext = DatabaseManager.shared.context
            managedContext.delete(cartItem)
            do {
                try managedContext.save()
            } catch _ {
                
            }
        }else{
            //update
            cartDao.updateCartQuantity(cartItem.productname!, cartItem.quantity - 1)
        }
        fetchData()
    }
}
