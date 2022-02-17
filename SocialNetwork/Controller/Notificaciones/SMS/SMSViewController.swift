//
//  SMSViewController.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 13/02/22.
//

import UIKit
import KVNProgress
import Material
import FirebaseFirestore

class SMSViewController: UIViewController {
    
    //MARK: - IBOutlet's
    @IBOutlet weak var tableView:UITableView!
    
    //MARK: - Var's
    var messages = LocalData.Mensajes
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - Helpers
    @objc func reloadData(){
        tableView.reloadData()
    }
}



//MARK: - UITableViewDataSource, UITableViewDelegate
extension SMSViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "smsCell", for: indexPath) as! smsCell
        let mensaje = messages[indexPath.row]
        cell.nombrePersonaLabel.text = mensaje.senderName
        cell.descripcionLabel.text = mensaje.description
        if let profile_path = mensaje.profile_path,
           let url = URL(string:profile_path){
            cell.imagenPerfilImageView.setImageWith(url, placeholderImage: nil,false)
        }
        return cell
    }
    

}




