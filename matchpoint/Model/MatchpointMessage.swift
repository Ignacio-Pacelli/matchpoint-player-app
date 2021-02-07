//
//  Chat.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 28/1/21.
//

struct MatchpointMessage: Decodable {
    let id : Int
    let sender: Player
    let content : String
}
