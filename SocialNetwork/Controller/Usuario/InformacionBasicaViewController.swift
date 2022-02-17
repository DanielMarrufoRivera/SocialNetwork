//
//  InformacionBasicaViewController.swift
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
class InformacionBasicaViewController: UIViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var imagenPerfilImageView: UIImageView!
    @IBOutlet weak var nombrePersonaLabel: UILabel!
    @IBOutlet weak var publicacionesView: UIView!
    @IBOutlet weak var interaccionesView: UIView!
    
    //MARK: - Var's
    var categories = ["Mis publicaciones"]
    
    var isMainUser: Bool = true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if NetworkCheck.isConnectedToNetwork() {
            print("You have internet connection!")
        } else {
            print("No internet connection!")
            connectionAlert()
        }
        self.interaccionesView.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.reloadData()
        if let nombreCompleto = UserManager.shared.getUserName(){
            nombrePersonaLabel.text = nombreCompleto
            if let profile_path = UserManager.shared.user["imagenPerfil"] as? String,
               let url = URL(string:profile_path){
                imagenPerfilImageView.setImageWith(url, placeholderImage: nil,false)
            }
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func logOutButtonTapped(_ sender: Any) {
        AuthManager.logOut { success, error in
            UIApplication.setRootView(LogInViewController.instantiate(from: .Login))
        }
    }
    
    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        print(sender)
        if sender.selectedSegmentIndex == 0{
            self.publicacionesView.isHidden = false
            self.interaccionesView.isHidden = true
        }else{
            self.publicacionesView.isHidden = true
            self.interaccionesView.isHidden = false
        }
        
    }
}

extension InformacionBasicaViewController : UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "publicationCell") as! PublicationRow
        cell.isMainUser = self.isMainUser
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Mosk Normal 400", size: 14)
        
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 260
    }
}
