//
//  CartTableViewCell.swift
//  Assignment1
//
//  Created by Sachin Rao on 18/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var removeCartButton: UIButton!
    @IBOutlet weak var quantity: UILabel!
    
    weak var removeCartDelegate: RemoveFromCarDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func handleRemoveFromCartButton(_ sender: UIButton) {
        UIUtils.animateView(sender, completionHandler: { finish in
            self.removeCartDelegate?.removeFromCart(index: sender.tag)
        })       
    }
}
