//
//  InsetTextField.swift
//  Assignment1
//
//  Created by Sachin Rao on 23/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class InsetTextField:UITextField{
    @IBInspectable var padding:UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0){
        didSet{
            self.setNeedsDisplay()   
        }
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
