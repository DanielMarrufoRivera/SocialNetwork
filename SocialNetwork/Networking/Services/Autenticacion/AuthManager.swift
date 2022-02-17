//
//  AuthManager.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 12/02/22.
//

import UIKit
import Firebase
import Alamofire
import FirebaseFirestore
import FirebaseAuth
import AuthenticationServices

class AuthManager: NSObject{
    
    //MARK: - Vars
    fileprivate var logInCompletionHandler:((_ success:Bool, _ error: Error?) -> Void)? = nil
    let internalError = NSError(domain:"", code:402, userInfo:[ NSLocalizedDescriptionKey:"Error interno"]) as Error
    
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    static let shared : AuthManager = {
        let instance = AuthManager()
        return instance
    }()
    
    
    
    //MARK: Email
    static func logInWithEmail(email:String!, password:String!, completion:((_ success:Bool, _ error: Error?) -> Void)?){
        Auth.auth().signIn(withEmail: email, password: password) { (dataResult, error) in
            if let error = error {
                completion?(false, error)
                return
            }else if let dataResult = dataResult{
                self.userDidLogin(user: dataResult.user, email: email)
                completion?(true, nil)
            }else{
                completion?(false, nil)
            }
        }
    }
    
    //MARK: - SIGN UP -
    //MARK: Email
    static func signUpWithEmail(email:String!, password:String!, name:String!,photoURL:String?, completion:((_ success:Bool, _ error: Error?) -> Void)?){
        Auth.auth().createUser(withEmail: email, password: password) { (dataResult, error) in
            if let error = error {
                completion?(false, error)
                return
            }else{
                let changeRequest = dataResult?.user.createProfileChangeRequest()
                changeRequest?.displayName = name
                changeRequest?.commitChanges() { (error) in
                    if let error = error{
                        completion?(false, error)
                    }else{
                        AuthManager.updateUserProperties(
                            loginMethod:"Email",
                            user:dataResult?.user,
                            email: email,
                            fullName: name,
                            photoURL:photoURL,
                            signUp: true,
                            completion: completion
                        )
                        
                    }
                }
            }
        }
    }
    
    //MARK: - CURRENT USER HELPERS -
    
    
    static func updateUserProperties(loginMethod:String, user:User!, email:String?, fullName:String?,photoURL:String?, signUp:Bool, completion:((_ success:Bool, _ error: Error?) -> Void)?){
        
        if signUp{
            
            var updatesDic:[String:Any] = [
                "creacion" : Timestamp(date: UIApplication.networkTime()),
                "key": AccountManager.shared.currentUserId() ?? ""
            ]
            
            if let fullName = fullName{
                updatesDic["nombreCompleto"] = fullName
            }
            
            if let photoURL = photoURL{
                updatesDic["imagenPerfil"] = photoURL
            }
            
            if let email = email{
                updatesDic["email"] = email
            }
            
            let ref = (UIApplication.shared.delegate as! AppDelegate).ref
            let userRef = ref.collection("US").document(AccountManager.shared.currentUserId() ?? "")
            
            
            userRef.setData(updatesDic, merge: true) { (error) in
                if let error = error{
                    completion?(false, error)
                }else{
                    self.userDidLogin(user: user, email: email)
                    completion?(true, nil)
                }
            }
            
        }else{
            self.userDidLogin(user: user, email: email)
            completion?(true, nil)
        }
    }
    
    static func userDidLogin(user:User, email:String?){
        UIApplication.appDelegate().initUserRelatedManagers()
        if let email = email{
            let topic = email.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")
            Messaging.messaging().subscribe(toTopic: "\(topic)")
            
        }else if let topic = user.displayName?.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_"){
            Messaging.messaging().subscribe(toTopic: "\(topic)")
        }
        Messaging.messaging().subscribe(toTopic: "\(user.uid)")
    }
    
    
    static func logOut(completion:((_ success:Bool, _ error: Error?) -> Void)?){
        if let uid = Auth.auth().currentUser?.uid{
            Messaging.messaging().unsubscribe(fromTopic: uid)
        }
        do {
            try Auth.auth().signOut()
            completion?(true, nil)
            
        } catch let signOutError as NSError {
            completion?(false, signOutError)
        }
    }
    
}
