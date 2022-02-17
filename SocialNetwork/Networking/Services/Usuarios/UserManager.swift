//
//  UserManager.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 13/02/22.
//


import LocalAuthentication
import CoreLocation
import UIKit
import FirebaseFirestore
import Alamofire
import FirebaseAuth


class UserManager: NSObject {
    
    //MARK: - Var's
    var user:[String:Any] = [:]
    var listener:ListenerRegistration? = nil
    static let shared : UserManager = {
        let instance = UserManager()
        return instance
    }()
    var userCache:[String:Any] = [:]
    
    //MARK: - Life cycle
    
    func initialize( completion: ((_ success:Bool) -> Void)?){
        if let userId = AccountManager.shared.currentUserId(){
            listener?.remove()
            listener = ref.collection("US").document("\(userId)").addSnapshotListener({ [weak self](snapshot, error) in
                guard let strongSelf = self else {
                    completion?(true)
                    return
                }
                
                if let data = snapshot?.data(){
                    strongSelf.user = data
                }
            })
        }else{
            completion?(true)
        }
    }
    
    //MARK: - Helpers
    
    func updateBasicInfo( imagenPerfil:String, completion:((_ success:Bool, _ error:Error?) -> Void)?) {
        if let user = Auth.auth().currentUser{
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.commitChanges() { (error) in
                if let error = error{
                    completion?(false, error)
                }else{
                    let userRef = self.ref.collection("US").document(AccountManager.shared.currentUserId() ?? "")
                    
                    userRef.setData(["imagenPerfil":imagenPerfil], merge: true, completion: { (error) in
                        if let error = error{
                            completion?(false, error)
                        }else{
                            completion?(true, nil)
                        }
                    })
                }
            }
        }else{
            completion?(false, nil)
        }
    }
    
    func getCurrentEmail() -> String{
        return user["email"] as? String ?? ""
    }
    func getUserName() -> String?{
        return user["nombreCompleto"] as? String ?? ""
    }
}


