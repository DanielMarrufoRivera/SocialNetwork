//
//  PersonCell.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 15/02/22.
//  
//

import UIKit

class PersonCell: UICollectionViewCell {
    
   @IBOutlet weak var imageView: UIImageView!
   @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        imageView.makeRounded()
    }
}
