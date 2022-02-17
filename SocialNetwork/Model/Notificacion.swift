//
//  Notificacion.swift
//  SocialNetwork
//
//  Created by Daniel Marrufo rivera on 16/02/22.
//

import Foundation

struct Notificacion: Codable {
    var id: Int
    var senderName: String
    var description: String
    var profile_path:String?
}
