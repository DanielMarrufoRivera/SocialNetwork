//
//  AppDelegate.swift
//  SocialNetwork
//
//  Created by Gina De La Rosa on 1/10/19.
//

import UIKit
import Firebase
import Material
import KVNProgress
import UserNotifications
import AVFoundation
import AlamofireImage
import TrueTime
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //MARK: - Global application vars
    var window: UIWindow?
    var globalRef: Firestore!
    var globalStorageRef: StorageReference!
    let timeClient = TrueTimeClient.sharedInstance
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        globalRef = Firestore.firestore()
        globalStorageRef = Storage.storage().reference()
        // Let's initiliaze window
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9960784314, alpha: 1)
        // Let's check if user availability
        if Auth.auth().currentUser == nil{
            // Show login page
            let loginViewController = LogInViewController.instantiate(from: .Login)
            self.window?.rootViewController = loginViewController
        }else{
            // Show home page
            let mainViewController = MainTabBarController.instantiate(from: .Main)
            self.window?.rootViewController = mainViewController
        }
        self.window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        initUserRelatedManagers()
        return true
    }
    
    func initUserRelatedManagers()  {
        UserManager.shared.initialize(completion: nil)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
            UserManager.shared.initialize(completion: nil)
    }
    

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

