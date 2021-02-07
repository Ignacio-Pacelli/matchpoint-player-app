//
//  Club.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 26/1/21.
//

struct Club : Decodable{
    let id: Int
    let name: String
    let picture: String
    let phone_number: String
    let location: Location
}
