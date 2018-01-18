//
//  UIUtils.swift
//  Assignment1
//
//  Created by Sachin Rao on 16/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import Foundation
import UIKit

public class UIUtils{
    
    
    public static func animateView(_ sender:UIView, completionHandler:@escaping (Bool)->Void){
        
        UIView.animate(withDuration: 0.250,
                       delay:0,
            usingSpringWithDamping:0.1,
            initialSpringVelocity:0.1,
                         animations: {
                            sender.transform = CGAffineTransform(scaleX: 0.850, y: 0.850)
                         },completion: { finish in
                            UIView.animate(withDuration: 0.250,
                                           delay:0,
                                           usingSpringWithDamping:0.1,
                                           initialSpringVelocity:0.1,
                                           animations: {
                                            sender.transform = CGAffineTransform.identity
                                           },
                                           completion: completionHandler)
                            
        })
    }
    
    /// method to show alert
    ///
    /// - Parameters:
    ///   - strTitle: Title of the alert
    ///   - strMessage: Body for the alert
    ///   - actionButtonText: positve button of the alert
    public static func showOKAlert(_ context: UIViewController, strTitle:String, strMessage:String, actionButtonText:String, execFunc: (()->Void)?){
        let alert=UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        let action=UIAlertAction(title: "\(actionButtonText)", style: .default, handler: {
            action in
            execFunc?()
        })
        alert.addAction(action)
        context.present(alert, animated: true, completion: nil)
    }
    

    /// This is a helper method to show the OK-Cancel AlertView to the user
    ///
    /// - Parameters:
    ///   - context: context in which the UIAlertView will be displayed
    ///   - strTitle: Title of the UIAlertView
    ///   - strMessage: Message of the UIAlertView
    ///   - positiveButtonText: positive button text
    ///   - negativeButtonText: negative button text
    ///   - positiveButtonAction: positive button action to be performed when the positive button is clicked
    ///   - negativeButtonAction: negative button action to be performed when the negative button is clicked
    public static func showCancelableAlert(_ context: UIViewController, strTitle:String, strMessage:String, positiveButtonText:String, negativeButtonText:String, positiveButtonAction: (()->Void)?, negativeButtonAction:(() -> Void)?){
        
        let alert=UIAlertController(title: strTitle, message: strMessage, preferredStyle: .actionSheet)
        
        let positiveAction=UIAlertAction(title: "\(positiveButtonText)", style: .default, handler: {
            action in
            positiveButtonAction?()
        })
        
        let negativeAction=UIAlertAction(title: "\(negativeButtonText)", style: .cancel, handler: {
            action in
         negativeButtonAction?()
        })
        
        alert.addAction(positiveAction)
        alert.addAction(negativeAction)
        context.present(alert, animated: true, completion: nil)
    }
}
