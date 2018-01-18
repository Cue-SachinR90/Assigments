//
//  AddToCartDelegate.swift
//  Assignment1
//
//  Created by Sachin Rao on 18/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import Foundation

/// My understanding is that using class, you guarantee that this protocol will be used only on classes and no other stuff like enums or structs.
protocol AddToCartDelegate: class {
    func addToCart(index: Int)
}
