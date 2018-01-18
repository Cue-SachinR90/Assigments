//
//  HomeTabController.swift
//  Assignment1
//
//  Created by Sachin Rao on 16/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import UIKit
//Home Screen Controllers
class HomeTabController: UITabBarController {
    
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
