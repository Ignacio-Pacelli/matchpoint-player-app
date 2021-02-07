//
//  Player.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 27/1/21.
//

import Foundation


struct Player: Decodable {
    let id : Int
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case email = "email"
    }
}

struct Players : Decodable{
    let players: [Player]
}

