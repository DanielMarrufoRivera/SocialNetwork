//
//  Publicacion.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 15/02/22.
//

import Foundation

// Properties correspond to the keys listed in the API
struct Publicacion: Codable {
    var id: Int
    var name: String
    var description: String
    var price: Double
    var imageURL: String?
    var profile_path:String?
}

