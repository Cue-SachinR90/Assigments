//
//  Extensions.swift
//  Assignment1
//
//  Created by Sachin Rao on 22/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import UIKit
extension UITextField{
    func setLeftPadding(with points:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: points, height: self.frame.size.height))
        self.leftView = paddingView
        //        Controls when the left overlay view appears in the text field.
//        The default value for this property is never. Note that the left overlay view flips automatically in a right-to-left user interface.
        self.leftViewMode = .always
    }
}
