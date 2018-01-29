//
//  NetworkManager.swift
//  Assignment1
//
//  Created by Sachin Rao on 29/01/18.
//  Copyright © 2018 Cuelogic Technologies. All rights reserved.
//

import Foundation

public class NetworkManager {
    
    private static var sharedNetworkManager:NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    private let myDefaultConfiguration = URLSessionConfiguration.default
    
    private lazy var defaultSession :URLSession = {
        let container = URLSession(configuration: myDefaultConfiguration)
        return container
    }()
    
    private init(){
        myDefaultConfiguration.allowsCellularAccess = false
        myDefaultConfiguration.waitsForConnectivity = true
    }
    
    class func getInstance() -> NetworkManager{
        return sharedNetworkManager
    }
    
    public func makeHttpRequest(using stringUrl:String, closure: @escaping (Data?,URLResponse?, Error?)->Void) ->Void{
        let url =  URL(string: stringUrl)
        let dataTask = defaultSession.dataTask(with: url!, completionHandler: closure)
        dataTask.resume()
    }
}
