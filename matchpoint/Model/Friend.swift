//
//  Friend.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 28/1/21.
//

import Foundation

struct Friend: Decodable {
    let id : Int
    let name: String
    let email: String
}


struct Friends : Decodable {
    let friends: [Friend]
}
