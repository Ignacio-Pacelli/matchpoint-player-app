//
//  Chat.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 28/1/21.
//

struct Chat: Decodable {
    let id : Int
    let participants: [Player]
    let lastMessage: MatchpointMessage?
}
