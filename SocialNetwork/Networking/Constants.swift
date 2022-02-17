//
//  Constants.swift
//  SocialNetwork
//
//  Created by Gina De La Rosa on 1/10/19.
//  Copyright © 2019 Gina De La Rosa. All rights reserved.
//
import Foundation
import UIKit


//MARK: - Storyboards

enum AppStoryboard: String {
    
    case Login = "LogIn"
    case Main = "Main"
    case SignUp = "SignUp"
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T : UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
}
//MARK: - Storyboards
enum StoryboardNames:String {
    case main = "Main"
    case login = "Login"
    case SignUp = "SignUp"
}

//MARK: - Fonts
struct AppFontName {
    static let regular = "Futura-Book"
    static let bold:String = {
        let fontNames = UIFont.fontNames(forFamilyName: "Futura")
        if fontNames.contains("Futura-Bold"){
            return "Futura-Bold"
        }
        
        return "Futura-Medium"
    }()
    
    static let italic = "Futura-MediumItalic"
    static let medium = "Futura-Medium"
}
struct Api {
    static let BASE_URL = "https://us-central1-bibliotecadecontenido.cloudfunctions.net/helloWorld"
    
}


