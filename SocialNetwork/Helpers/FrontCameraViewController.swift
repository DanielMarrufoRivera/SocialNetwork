//
//  FrontCameraViewController.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 15/02/22.
//

import UIKit
import CameraManager
import Material

protocol FrontCameraViewControllerDelegate {
    func userTakeImage(image: UIImage)
    func userCancelTakeImage()
}
class FrontCameraViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet var cameraView: UIView!
    @IBOutlet var captureButton: UIButton!
    @IBOutlet weak var focusIndicator: UIImageView!
    //MARK: - Var's
    let cameraManager = CameraManager()
    var imagePicker = UIImagePickerController()
    var delegate:FrontCameraViewControllerDelegate? = nil
    var hideGalleryButton = false
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCameraManager()
        cameraManager.cameraOutputQuality = .high
        let currentCameraState = cameraManager.currentCameraStatus()
        if currentCameraState == .notDetermined {
            askForCameraPermissions()
        } else if currentCameraState == .ready {
            addCameraToView()
        } else {
            askForCameraPermissions()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        cameraManager.resumeCaptureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraManager.stopCaptureSession()
    }
    
    // MARK: - ViewController
    fileprivate func setupCameraManager() {
        cameraManager.cameraDevice = .front
    }
    
    fileprivate func addCameraToView() {
        cameraManager.addPreviewLayerToView(cameraView)
        cameraManager.showErrorBlock = { [weak self] (erTitle: String, erMessage: String) -> Void in
            
            let alertController = UIAlertController(title: erTitle, message: erMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) -> Void in }))
            
            self?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func focusIndicatorAnimate(to targetPoint: CGPoint) {
        focusIndicator.center = targetPoint
        focusIndicator.alpha = 0.0
        focusIndicator.isHidden = false
        UIView.animate(withDuration: 0.4, animations: {() -> Void in
            self.focusIndicator.alpha = 1.0
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: 0.4, animations: {() -> Void in
                self.focusIndicator.alpha = 0.0
            })
        })
    }
    // MARK: - @IBActions
    
    // MARK: CameraVC Actions
    
    
    @IBAction func takePictureButtonTapped(_ sender: UIButton) {
        cameraManager.capturePictureWithCompletion {[weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .failure:
                strongSelf.cameraManager.showErrorBlock("Error occurred", "Cannot save picture.")
            case .success(let content):
                if let image = content.asImage{
                    strongSelf.delegate?.userTakeImage(image: image)
                }
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.delegate?.userCancelTakeImage()
        self.dismiss(animated: true, completion: nil)
    }
    
    func askForCameraPermissions() {
        cameraManager.askUserForCameraPermission { permissionGranted in
            if permissionGranted {
                self.addCameraToView()
            } else {
                let alert = UIAlertController(title: nil,
                                              message: "Acceso a camará deshabilitado, para permitir que IDue acceda a la cámara, selecciona Configuración > Privacidad > Cámara. En Permitir el acceso a la cámara en este dispositivo",
                                              preferredStyle: UIAlertController.Style.alert)
                
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler:{ _ in
                    self.dismiss(animated: true, completion: nil)
                })
                alert.addAction(okAction)
                
                let settingsAction = UIAlertAction(title: "Configuración", style: .default, handler: { _ in
                    // Take the user to Settings app to possibly change permission.
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            })
                        } else {
                            UIApplication.shared.openURL(settingsUrl)
                        }
                    }
                })
                alert.addAction(settingsAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}


// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

public extension Data {
    func printExifData() {
        let cfdata: CFData = self as CFData
        let imageSourceRef = CGImageSourceCreateWithData(cfdata, nil)
        let imageProperties = CGImageSourceCopyMetadataAtIndex(imageSourceRef!, 0, nil)!
        
        let mutableMetadata = CGImageMetadataCreateMutableCopy(imageProperties)!
        
        CGImageMetadataEnumerateTagsUsingBlock(mutableMetadata, nil, nil) { _, tag in
            print(CGImageMetadataTagCopyName(tag)!, ":", CGImageMetadataTagCopyValue(tag)!)
            return true
        }
    }
}
