//
//  LoginViewController.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 12/02/22.
//
//

import UIKit
import LocalAuthentication
import CoreLocation
import UIKit
import KVNProgress
import Material
import TTTAttributedLabel
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth
import AuthenticationServices

class LogInViewController: UIViewController {
    //MARK: - IBOutlets LogIn
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailLogInTextField: LocalizedErrorTextField!
    @IBOutlet weak var passwordLogInTextField: PasswordTextField!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var registerLabel: TTTAttributedLabel!
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Life cycle for LogIn
        passwordLogInTextField.textInset = 10
        emailLogInTextField.textInset = 10
        self.view.layoutIfNeeded()
        if #available(iOS 13.0, *) {
            self.navigationItem.compactAppearance?.backgroundColor = UIColor.red
        }
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 29, green: 103, blue: 189, alpha: 1)
        navigationItem.rightViews = [FlatButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))]
        emailLogInTextField.placeholder = "Email"
        passwordLogInTextField.placeholder = "Contraseña"
        emailLogInTextField.isErrorRevealed = false
        passwordLogInTextField.isErrorRevealed = false
        
        
        
        let text = (registerLabel.text)!
        let underlineAttriString = NSMutableAttributedString(string: text as! String)
        let allTexto = (text as! NSString).range(of: "¿Eres nuevo? Registrate.")
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value:  UIColor(red: 151, green: 151, blue: 151, alpha: 1), range: allTexto)
        
        let range = (text as! NSString).range(of: "Registrate")
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value:  Colors.primary.darken3, range: range)
        
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value:  UIFont(name: AppFontName.medium, size: 12.0)!, range: range)
        
        registerLabel.attributedText = underlineAttriString
        registerLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("Deinit LoginViewController")
    }
    
    //MARK: - Helpers LogIn
    
    func validLogInInfo() -> Bool{
        if emailLogInTextField.text == "" {
            
            return false
        }else if passwordLogInTextField.text == ""{
            let _ = passwordLogInTextField.becomeFirstResponder()
            return false
        }
        return true
    }
    
    
    func loginComplete(){
        if Auth.auth().currentUser != nil {
            UIApplication.setRootView(MainTabBarController.instantiate(from: .Main))
        }
    }
    
    
    
    //MARK: - Button action
    
    @IBAction func logInButtonTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        let emailUser = defaults.string(forKey: "emailUser")
        emailLogInTextField.isErrorRevealed = emailLogInTextField.text == ""
        passwordLogInTextField.isErrorRevealed = passwordLogInTextField.text == ""
        if emailLogInTextField.text == ""{
            let _ = emailLogInTextField.becomeFirstResponder()
        }
        if passwordLogInTextField.text == ""{
            let _ = passwordLogInTextField.becomeFirstResponder()
        }
        
        if  !emailLogInTextField.text!.isValidEmail() {
            let _ = emailLogInTextField.becomeFirstResponder()
            self.showAlertWithMessage("Favor de ingresar un email valido")
            return
        }
        
        let window = UIApplication.shared.keyWindow!
        KVNProgress.show(withStatus: nil, on: window)
        AuthManager.logInWithEmail(email: emailLogInTextField.text!, password: passwordLogInTextField.text!, completion: {[weak self] (success, error) in
            guard let strongSelf = self else {
                return
            }
            if success && error == nil{
                strongSelf.loginComplete()
            }else if let error = error{
                if let errorName = (error as NSError).userInfo["error_name"] as? String,
                   errorName == "ERROR_USER_NOT_FOUND" || errorName == "ERROR_WRONG_PASSWORD"{
                    strongSelf.showAlertWithMessage("El usuario o la contraseña ingresada son incorrectos.")
                }else{
                    if (error as NSError).code == 17010{
                        strongSelf.showAlertWithMessage("Se ha alcanzado el límite de intentos incorrectos. Intentar nuevamente mas tarde.")
                    }else if (error as NSError).code == 17011{
                        strongSelf.showAlertWithMessage("No hay un registro de usuario correspondiente a este email")
                    }else if (error as NSError).code == 17020{
                        strongSelf.showAlertWithMessage("No fue posible conectarse a internet.")
                    }else{
                        strongSelf.showAlertWithError(error)
                    }
                }
            }
        })
    }
    
    
    //MARK: - Button actions
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let text = (registerLabel.text)!
        let range = (text as! NSString).range(of: "Registrate")
        if gesture.didTapAttributedTextInLabel(label: registerLabel, inRange: range) {
            UIApplication.setRootView(SignUpViewController.instantiate(from: .SignUp))
        }
    }
}

//MARK: - UITextFieldDelegate
extension LogInViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case emailLogInTextField:
            emailLogInTextField.isActivated = true
            break
        case passwordLogInTextField:
            passwordLogInTextField.isActivated = true
            break
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case emailLogInTextField:
            emailLogInTextField.isActivated = false
            break
        case passwordLogInTextField:
            passwordLogInTextField.isActivated = false
            break
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag: Int = textField.tag + 1
        let nextResponder: UIResponder? = textField.superview?.viewWithTag(nextTag)
        if nextResponder != nil {
            nextResponder?.becomeFirstResponder()
        }else {
            textField.resignFirstResponder()
        }
        return false
    }
}





@available(iOS 13.0, *)
extension LogInViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}


//MARK: - extensionsSignUp
extension UITapGestureRecognizer {
    
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                          y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
}
