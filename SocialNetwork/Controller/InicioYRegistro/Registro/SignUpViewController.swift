//
//  SignUpViewController.swift
//
//  Created by Daniel Marrufo rivera on 13/02/22.
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

class SignUpViewController: UIViewController {
    
    //MARK: - IBOutlets SignUp
    @IBOutlet weak var imagenPerfilImageView: UIImageView!
    @IBOutlet weak var imagenPerfilButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var fullNameTextField: LocalizedErrorTextField!
    @IBOutlet weak var emailSignUpTextField: LocalizedErrorTextField!
    @IBOutlet weak var passwordSignUpTextField: PasswordTextField!
    @IBOutlet weak var confirmPasswordTextField: PasswordTextField!
    @IBOutlet weak var logInLabel: TTTAttributedLabel!
    
    //MARK: - Var's SignUP
    var uploadAttempts = 0
    var addedImage = false
    var securityLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 30))
    var imagenPerfil:String = "person"
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Life cycle for LogIn
        
        let text = (logInLabel.text)!
        let underlineAttriString = NSMutableAttributedString(string: text as! String)
        let allTexto = (text as! NSString).range(of: "¿Ya tienes cuenta? Inicia sesión")
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value:  UIColor(red: 151, green: 151, blue: 151, alpha: 1), range: allTexto)
        
        let range = (text as! NSString).range(of: "Inicia sesión")
        underlineAttriString.addAttribute(NSAttributedString.Key.foregroundColor, value:  Colors.primary.darken3, range: range)
        
        underlineAttriString.addAttribute(NSAttributedString.Key.font, value:  UIFont(name: AppFontName.medium, size: 12.0)!, range: range)
        
        logInLabel.attributedText = underlineAttriString
        logInLabel.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        startSignUp()
        
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
    
    //MARK: - Helpers SignUp
    
    func startSignUp(){
        passwordSignUpTextField.delegate = self
        fullNameTextField.placeholder = "Nombre completo"
        emailSignUpTextField.placeholder = "Email"
        passwordSignUpTextField.placeholder = "Contraseña"
        confirmPasswordTextField.placeholder = "Confirmar contraseña"
        emailSignUpTextField.isErrorRevealed = false
        confirmPasswordTextField.isErrorRevealed = false
        securityLabel.textAlignment = .right
        securityLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        securityLabel.minimumScaleFactor = 0.5
        securityLabel.numberOfLines = 1
        passwordSignUpTextField.rightView?.grid.views.insert(securityLabel, at: 0)
        passwordSignUpTextField.rightViewMode = .always
        confirmPasswordTextField.rightViewMode = .always
    }
    
    func validSignUpInfo() -> String?{
        emailSignUpTextField.isErrorRevealed = !emailSignUpTextField.text!.isValidEmail()
        if emailSignUpTextField.text == ""{
            let _ = emailSignUpTextField.becomeFirstResponder()
        }
        self.view.layoutIfNeeded()
        
        let isValid = isValidPassword (passwordSignUpTextField.text!)
        if  isValid == !isValidPassword (passwordSignUpTextField.text!){
            self.view.layoutIfNeeded()
            return "Contraseña insegura"
        }else{
            self.view.layoutIfNeeded()
        }
        if fullNameTextField.text == ""{
            self.view.layoutIfNeeded()
            let _ = fullNameTextField.becomeFirstResponder()
            return "Favor de ingresar tu nombre completo."
        }
        if passwordSignUpTextField.text == ""{
            self.view.layoutIfNeeded()
            let _ = passwordSignUpTextField.becomeFirstResponder()
            return "Contraseña vacía"
        }else{
            self.view.layoutIfNeeded()
            if passwordSignUpTextField.text != confirmPasswordTextField.text{
                self.view.layoutIfNeeded()
                let _ = passwordSignUpTextField.becomeFirstResponder()
                return "No coinciden las contraseñas"
            }
        }
        if !emailSignUpTextField.text!.isValidEmail() {
            self.view.layoutIfNeeded()
            let _ = emailSignUpTextField.becomeFirstResponder()
            return "Email invalido, asegurate de ingresar un email correcto"
        }
        
        return nil
    }
    
    func isValidPassword(_ text:String) -> Bool{
        if text.count < 8{
            passwordSignUpTextField.isErrorRevealed = true
            passwordSignUpTextField.detail = "La contraseña es muy corta"
            self.view.layoutIfNeeded()
            
            securityLabel.text = "Débil"
            securityLabel.textColor = #colorLiteral(red: 0.8901960784, green: 0, blue: 0, alpha: 1)
            
            return false
        }else{
            passwordSignUpTextField.isErrorRevealed = false
            self.view.layoutIfNeeded()
            let containsLowercaseLetter = text.rangeOfCharacter(from: CharacterSet.lowercaseLetters) != nil
            let containsSymbol = text.rangeOfCharacter(from: CharacterSet(charactersIn: "/\\[\\]!@#¨$%^&*()\\-_=+{}|?>.<,`':;~\"¿¬°´")) != nil
            let containsUppercaseLetter = text.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil
            let containsNumber = text.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
            
            if containsLowercaseLetter && containsUppercaseLetter && containsNumber && containsSymbol{
                if text.count < 16{
                    securityLabel.text = "aceptable"
                    securityLabel.textColor = #colorLiteral(red: 0.9607843137, green: 0.7058823529, blue: 0.2, alpha: 1)
                }else{
                    securityLabel.text = "segura"
                    securityLabel.textColor = #colorLiteral(red: 0, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                }
            }else{
                securityLabel.text = "débil"
                securityLabel.textColor = #colorLiteral(red: 0.8901960784, green: 0, blue: 0, alpha: 1)
            }
            
            return true
        }
        
    }
    
    
    func saveImage() {
        KVNProgress.show()
        if let image = imagenPerfilImageView.image{
            var compression:CGFloat = 0.9
            let maxCompression:CGFloat = 0.1
            let maxFileSize = 250*1024
            
            if let imageData = image.jpegData(compressionQuality: compression){
                var data = imageData
                
                while (imageData.count > maxFileSize && compression > maxCompression){
                    compression -= 0.1;
                    data = image.jpegData(compressionQuality: compression)!
                }
                
                let photoRef = self.storageRef.child("Us/\(AccountManager.shared.currentUserId() ?? "")/\(self.fullNameTextField.text ?? "imagenPerfil").jpg")
                
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpeg"
                
                let uploadTask = photoRef.putData(data, metadata: metadata) { [weak self] metadata, error in
                    guard let strongSelf = self else {
                        return
                    }
                    KVNProgress.dismiss()
                    if let error = error {
                        if strongSelf.uploadAttempts < 5{
                            strongSelf.uploadAttempts += 1
                        }else{
                            strongSelf.uploadAttempts = 0
                            strongSelf.showAlertWithError(error)
                        }
                    } else {
                        strongSelf.uploadAttempts = 0
                        
                        photoRef.downloadURL(completion: {[weak self] (url, error) in
                            guard let strongSelf = self else { return }
                            if let error = error{
                                strongSelf.showAlertWithError(error)
                            }else{
                                strongSelf.imagenPerfil = url?.absoluteString ?? "person"
                                
                                UserManager.shared.updateBasicInfo(imagenPerfil: strongSelf.imagenPerfil) { success, error in
                                    if success && error == nil{
                                        
                                        UIApplication.setRootView(MainTabBarController.instantiate(from: .Main))
                                    }else if let error = error as NSError?{
                                        strongSelf.showAlertWithError(error)
                                    }else{
                                        KVNProgress.dismiss()
                                    }
                                }
                            }
                        })
                    }
                }
                
                uploadTask.observe(.progress) { snapshot in
                    if let progress = snapshot.progress{
                        KVNProgress.show(CGFloat(progress.fractionCompleted), status: "Actualizando imagen")
                    }
                }
            }
        }
    }
    
    
    //MARK: - Button actions SignUp
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
        let text = (logInLabel.text)!
        let range = (text as! NSString).range(of: "Inicia sesión")
        if gesture.didTapAttributedTextInLogInLabel(label: logInLabel, inRange: range){
            UIApplication.setRootView(LogInViewController.instantiate(from: .Login))
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        if let error = validSignUpInfo(){
            showAlertWithMessage(error)
            return
        }
        
        let window = UIApplication.shared.keyWindow!
        KVNProgress.show(withStatus: nil, on: window)
        
        AuthManager.signUpWithEmail(email: emailSignUpTextField.text!.lowercased(), password: passwordSignUpTextField.text!, name: fullNameTextField.text, photoURL: self.imagenPerfil, completion: {[weak self] (success, error) in
            guard let strongSelf = self else {
                return
            }
            if success && error == nil{
                if strongSelf.addedImage{
                    strongSelf.saveImage()
                }else{
                    UIApplication.setRootView(MainTabBarController.instantiate(from: .Main))
                }
            }else if let error = error as NSError?{
                if error.code == 17007{
                    strongSelf.showAlertWithMessage("Cuenta existente")
                }else{
                    strongSelf.showAlertWithError(error)
                }
            }else{
                KVNProgress.dismiss()
            }
        })
    }
    @IBAction func imagenPerfilButtonTapped(_ sender: UIButton) {
        if let vc = UIStoryboard.viewController("FrontCameraViewController", fromStoryboard: .SignUp) as? FrontCameraViewController{
            vc.delegate = self
            let nvc = AppNavigationController(rootViewController: vc)
            nvc.modalPresentationStyle = .fullScreen
            self.present(nvc, animated: true, completion: nil)
        }
    }
    
    
}

//MARK: - UITextFieldDelegate
extension SignUpViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        logInButton.isEnabled = validLogInInfo()
        if textField == passwordSignUpTextField{
            if string == ""{   //backspace
                let _ = isValidPassword (String(passwordSignUpTextField.text!.dropLast()))
            }else{
                let _ = isValidPassword (passwordSignUpTextField.text! + string)
            }
        }else if textField == confirmPasswordTextField{
            var newText = ""
            if string == ""{   //backspace
                newText = String(confirmPasswordTextField.text!.dropLast())
            }else{
                newText = confirmPasswordTextField.text! + string
            }
            
            if passwordSignUpTextField.text != newText{
                confirmPasswordTextField.isErrorRevealed = true
                confirmPasswordTextField.detail =  "Las contraseñas no coinciden"
            }else{
                confirmPasswordTextField.isErrorRevealed = false
                
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField{
        case fullNameTextField:
            fullNameTextField.isActivated = true
            break
        case emailSignUpTextField:
            emailSignUpTextField.isActivated = true
            break
        case passwordSignUpTextField:
            passwordSignUpTextField.isActivated = true
            break
        case confirmPasswordTextField:
            confirmPasswordTextField.isActivated = true
            break
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case fullNameTextField:
            fullNameTextField.isActivated = false
            break
        case emailSignUpTextField:
            emailSignUpTextField.isActivated = false
            break
        case passwordSignUpTextField:
            passwordSignUpTextField.isActivated = false
            break
        case confirmPasswordTextField:
            confirmPasswordTextField.isActivated = false
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




//MARK: - extensionsSignUp
extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLogInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
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


//MARK: - FrontCameraViewControllerDelegate
extension SignUpViewController:FrontCameraViewControllerDelegate{
    func userTakeImage(image: UIImage) {
        
        self.dismiss(animated: true, completion: nil)
        self.addedImage = true
        self.imagenPerfilImageView.image = image
    }
    func userCancelTakeImage(){}
}
