//
//  SucursalManager.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 16/02/22.
//

import UIKit

class SucursalManager: NSObject {
    
    static let shared : SucursalManager = {
        let instance = SucursalManager()
        return instance
    }()
    
    func getInfo(completion:((_ result:[String:Any]?, _ error:Error?) -> Void)?) {
        CloudFunctionManager.request() { (result, error) in
            if let error = error as NSError? {
                completion?(nil, error)
            }else if let result = result{
                completion?(result, nil)
            }else{
                completion?(nil, nil)
            }
        }
    }
}
