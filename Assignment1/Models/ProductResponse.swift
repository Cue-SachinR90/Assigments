//
//  ProductResponse.swift
//  Assignment1
//
//  Created by Sachin Rao on 29/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import Foundation
public struct ProductResponse: Codable{
    
    var products:[ProductModel]?
    
    enum CodingKeys: String, CodingKey{
        case products
    }
}
