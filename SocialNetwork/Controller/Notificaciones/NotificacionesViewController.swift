//
//  SMSViewController.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 13/02/22.
//

import UIKit

class NotificacionesViewController: UIViewController {
    
    //MARK: - IBOutlet's
    @IBOutlet weak var tableView:UITableView!
    
    //MARK: - Var's
    var notificaciones = LocalData.Notificaciones
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    
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
extension NotificacionesViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificaciones.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificacionCell
        let notificacion = notificaciones[indexPath.row]
        cell.nombrePersonaLabel.text = notificacion.senderName
        cell.descripcionLabel.text = notificacion.description
        if let profile_path = notificacion.profile_path,
           let url = URL(string:profile_path){
            cell.imagenPerfilImageView.setImageWith(url, placeholderImage: nil,false)
        }
        return cell
    }
}

