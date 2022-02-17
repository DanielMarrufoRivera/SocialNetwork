//
//  ActorRow.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 15/02/22.
//

import UIKit

class PersonsRow: UITableViewCell {
    
    var cancelRequest: Bool = false
    var personas = LocalData.Personas
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        loadTrendingData()
    }
    
    private func loadTrendingData(onPage page: Int = 1) {
    }
}

extension PersonsRow: UICollectionViewDataSource, UICollectionViewDataSourcePrefetching, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! PersonCell
        let person = personas[indexPath.row]
        if let profile_path = person.profile_path,
           let url = URL(string:profile_path){
            cell.imageView.setImageWith(url, placeholderImage: nil,false)
            cell.activityIndicator.alpha = 0.0
            cell.activityIndicator.stopAnimating()
        }
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
