
//  Extensions.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 12/02/22.
//

import Foundation
import UIKit
import Foundation
import FirebaseFirestore
import CoreGraphics
import AlamofireImage
import MapKit
import KVNProgress
import Material
import CoreImage
import FirebaseStorage



extension UIImageView {
    // Make image rounded
    func makeRounded() {
        let radius = self.frame.width/2.0
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    // Adds Blur
    func addBlurEffect()
    {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.7
        blurEffectView.frame = self.bounds
        self.addSubview(blurEffectView)
    }
    
    func setImageWith(_ url:URL, placeholderImage:UIImage?, _ runImageTransitionIfCached:Bool){
        self.af_setImage(withURL: url,
                         placeholderImage: placeholderImage,
                         filter: nil,
                         progress: nil,
                         progressQueue: .main,
                         imageTransition: UIImageView.ImageTransition.crossDissolve(0.3),
                         runImageTransitionIfCached: runImageTransitionIfCached,
                         completion: nil)
    }
    
    
    func applyShadow() {
        let layer           = self.layer
        layer.shadowColor   = UIColor.black.cgColor
        layer.shadowOffset  = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.6
        layer.shadowRadius  = 3
        clipsToBounds = false
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        tintColorDidChange()
        
    }
}

extension UIColor {
    convenience init(hex:String){
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            self.init(ciColor: .gray)
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
// Converts String to Date
extension String {
    
    func convertDateString() -> String? {
        return convert(dateString: self, fromDateFormat: "yyyy-MM-dd", toDateFormat: "MMM d, yyyy")
    }
    
    func convert(dateString: String, fromDateFormat: String, toDateFormat: String) -> String? {
        
        let fromDateFormatter = DateFormatter()
        fromDateFormatter.dateFormat = fromDateFormat
        
        if let fromDateObject = fromDateFormatter.date(from: dateString) {
            
            let toDateFormatter = DateFormatter()
            toDateFormatter.dateFormat = toDateFormat
            
            let newDateString = toDateFormatter.string(from: fromDateObject)
            return newDateString
        }
        return nil
    }
}
// Assists with pushing data to detail view controller
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

// Assists with hiding keyboard
extension UIViewController {
    // Hides Keyboard when tapped: Not sure if this works
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Creates an alert for connection
    func connectionAlert() {
        let alert = UIAlertController(title: "Uh Oh", message: "You have no network connection. Please try connecting again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


//MARK: -UIViewController

extension UIViewController {
    
    func showAlertWithError(_ error:Error!) {
        KVNProgress.dismiss()
        let alert = UIAlertController(title: nil, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithMessage(_ message:String) {
        KVNProgress.dismiss()
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithTitleAndMessage(_ title:String,_ message:String) {
        KVNProgress.dismiss()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(from: AppStoryboard) -> Self {
        return from.viewController(viewControllerClass: self)
    }
}
//MARK: -NSObject
public extension NSObject {
    var ref:Firestore { return (UIApplication.shared.delegate as! AppDelegate).globalRef}
    
    var storageRef:StorageReference { return (UIApplication.shared.delegate as! AppDelegate).globalStorageRef}
    
    
    func setAssociatedObject<T>(_ value: T?, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
        if let valueAsAnyObject = value {
            objc_setAssociatedObject(self, associativeKey, valueAsAnyObject, policy)
        }
    }
    
    func getAssociatedObject(_ associativeKey: UnsafeRawPointer) -> Any? {
        guard let valueAsType = objc_getAssociatedObject(self, associativeKey) else {
            return nil
        }
        return valueAsType
    }
    
}

extension UIApplication {
    class var storyboardID: String {
        return "\(self)"
    }
    
    class func networkTime() -> Date{
        return appDelegate().timeClient.referenceTime?.now() ?? Date()
    }
    class func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    
    
    static var loginAnimation: UIView.AnimationOptions = .transitionFlipFromRight
    static var logoutAnimation: UIView.AnimationOptions = .transitionCrossDissolve
    
    public static func setRootView(_ viewController: UIViewController,
                                   options: UIView.AnimationOptions = .transitionFlipFromRight,
                                   animated: Bool = true,
                                   duration: TimeInterval = 0.5,
                                   completion: (() -> Void)? = nil) {
        guard animated else {
            UIApplication.shared.keyWindow?.rootViewController = viewController
            return
        }
        
        UIView.transition(with: UIApplication.shared.keyWindow!, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            UIApplication.shared.keyWindow?.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
    
}

extension String{
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

//MARK: -UIStoryboard
extension UIStoryboard {
    class func viewController(_ identifier: String, fromStoryboard storyboardName:StoryboardNames) -> UIViewController {
        return UIStoryboard(name: storyboardName.rawValue, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}
