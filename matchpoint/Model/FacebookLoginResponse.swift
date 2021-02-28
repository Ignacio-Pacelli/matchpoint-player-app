//
//  FacebookLoginResponse.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 9/2/21.
//

import Foundation

struct FacebookLoginResponse: Decodable {
    let token: String
    let player: Player
}
