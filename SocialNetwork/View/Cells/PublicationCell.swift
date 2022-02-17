//
//  PublicationCell.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 15/02/22.
//  
//

import UIKit

class PublicationCell: UICollectionViewCell {

    @IBOutlet weak var imagenPerfilImageView: UIImageView!
    @IBOutlet weak var imagenPublicacionImageView: UIImageView!
    @IBOutlet weak var nombrePersonaLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
