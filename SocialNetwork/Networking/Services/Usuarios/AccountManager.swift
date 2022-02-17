//
//  AccountManager.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 13/02/22.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import AuthenticationServices

class AccountManager: NSObject {
    var userId:String?
    static let shared : AccountManager = {
        let instance = AccountManager()
        return instance
    }()
    
    func currentUserId() -> String?{
        if userId != nil{
            return userId
        }
        return Auth.auth().currentUser?.uid
    }
}
