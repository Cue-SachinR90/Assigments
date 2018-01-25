//
//  ProductCollectionViewCell.swift
//  Assignment1
//
//  Created by Sachin Rao on 18/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productImageLabel: UIImageView!
    
    @IBOutlet weak var vendorNameLabel: UILabel!
    
    @IBOutlet weak var priceNameLabel: UILabel!
    
    @IBOutlet weak var addToCartButtonCell: UIButton!
    
    weak var addCartDelegate:AddToCartDelegate?
    
    @IBAction func handleAddToCartButton(_ sender: UIButton) {
        UIUtils.animateView(sender, completionHandler: { finish in
            self.addCartDelegate?.addToCart(index: sender.tag)
        })
        addCartClosure?(sender.tag)
    }
    var addCartClosure :((Int) -> Void)?

}
