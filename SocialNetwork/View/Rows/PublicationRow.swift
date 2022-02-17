//
//  PublicationRow.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 15/02/22.
//

import UIKit

class PublicationRow: UITableViewCell {

    var isMainUser: Bool = false
    var publicaciones = LocalData.Publicaciones
    
    @IBOutlet weak var publicacionCollectionView: UICollectionView!
 
    override func awakeFromNib() {
        loadTrendingData()
    }
    
    private func loadTrendingData(onPage page: Int = 1) {
    }
}

extension PublicationRow: UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return publicaciones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "publicationCell", for: indexPath) as! PublicationCell
        let publicacion = publicaciones[indexPath.row]
        if isMainUser,
           let nombreCompleto = UserManager.shared.getUserName(){
            if let profile_path = UserManager.shared.user["imagenPerfil"] as? String,
               let url = URL(string:profile_path){
                cell.imagenPerfilImageView.setImageWith(url, placeholderImage: nil,false)
                cell.activityIndicator.alpha = 0.0
                cell.activityIndicator.stopAnimating()
            }
            cell.nombrePersonaLabel.text = nombreCompleto
        }else{
            if let profile_path = publicacion.profile_path,
               let url = URL(string:profile_path){
                cell.imagenPerfilImageView.setImageWith(url, placeholderImage: nil,false)
                cell.activityIndicator.alpha = 0.0
                cell.activityIndicator.stopAnimating()
            }
            cell.nombrePersonaLabel.text = publicacion.name
        }
        if let imageURL = publicacion.imageURL,
           let url = URL(string:imageURL){
            cell.imagenPublicacionImageView.setImageWith(url, placeholderImage: nil,false)
            cell.activityIndicator.alpha = 0.0
            cell.activityIndicator.stopAnimating()
        }
        cell.descripcionLabel.text = publicacion.description
        cell.precioLabel.text = "$ \(publicacion.price)"
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        // Begin asynchronously fetching data for the requested index paths.
        for item in indexPaths {
            print ( "Prefetching Rows: \( item.row)" )
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
}
