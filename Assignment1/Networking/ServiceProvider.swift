//
//  ServiceProvider.swift
//  Assignment1
//
//  Created by Sachin Rao on 29/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import Foundation
public protocol SessionResult {
    func onSuccess(data: Data?, response: URLResponse?)
    func onFailure(error: Error?)
    
}

public class ServiceProvider{
    
    public func getProductData(fromUrl:String, sessionResultDelegate: SessionResult?) -> Void{
        let httpRequest = NetworkManager.getInstance()
        httpRequest.makeHttpRequest(using: fromUrl){
            data, response, error in
            if let error = error{
                print(error)
                sessionResultDelegate?.onFailure(error: error)
            }else{
                sessionResultDelegate?.onSuccess(data: data, response: response)
            }
        }
    }
}
