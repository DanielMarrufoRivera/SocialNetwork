//
//  SucursalViewController.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 16/02/22.
//  
//

import UIKit
import KVNProgress

class SucursalViewController: UIViewController {
    
    //MARK: - IBOutlet's
    @IBOutlet weak var tableView:UITableView!
    //MARK: - Var's
    var colores:[String] = []
    var preguntas:[[String:Any]] = []
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        KVNProgress.show()
        SucursalManager.shared.getInfo { result, error in
            if let error = error{
                self.showAlertWithError(error)
            }else if let preguntas = result?["questions"] as? [[String:Any]],
                     let colores = result?["colors"] as? [String]{
                KVNProgress.dismiss()
                self.preguntas = preguntas
                self.colores = colores
                self.reloadData()
            }
        }
        
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
        self.tableView.reloadData()
    }
    
    
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension SucursalViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preguntas.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EncuestaCell", for: indexPath) as! EncuestaCell
        let rowData = preguntas[indexPath.row]
        cell.loadCellWithData(rowData,colores)
        return cell
    }
}

