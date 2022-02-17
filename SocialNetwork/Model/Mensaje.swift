//
//  Mensaje.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 15/02/22.
//

import Foundation

struct Mensaje: Codable {
    var id: Int
    var senderName: String
    var description: String
    var profile_path:String?
}
