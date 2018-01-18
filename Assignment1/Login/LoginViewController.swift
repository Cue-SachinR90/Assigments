//
//  LoginViewController.swift
//  Assignment1
//
//  Created by Sachin Rao on 16/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK:- private methods
    
    /// Validate the Email and Password
    ///
    /// - Returns: true/false flags based on email/password are correct or not
    private func validateLogin() -> Bool{
        var flag:Bool! = true
        //check if the email is valid or not or check if password is valid or not
        if (!isValidEmail(emailTextField?.text!)) ||
            (!isValidPassword(passwordTextField?.text!)){
            
            UIUtils.showOKAlert(self,
                              strTitle: "Invalid Email/Password",
                              strMessage: "Please enter valid email/password",
                              actionButtonText: "Ok",
                              execFunc: nil)
            
            flag = false
        }
        return flag
    }
    
    /// Check if specified string is a valid email address or not
    ///
    /// - Parameter email: Email Id to be validated
    /// - Returns: true/false based on the condition of the valid email address
    private func isValidEmail(_ email:String?)->Bool{
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    /// Check if the specified String is a valid password or not
    ///
    /// - Parameter password: Entered password
    /// - Returns: true/false if the password is correct or not
    private func isValidPassword(_ password:String?)->Bool{
        
        return password!.count >= 8
        //        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{6,}"
        //        let passwordTest = NSPredicate(format:"SELF MATCHES[c]%@",passwordRegex)
        //        return passwordTest.evaluate(with:password)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return validateLogin()
    }
   
}
