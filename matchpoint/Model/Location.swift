//
//  Location.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 30/1/21.
//

struct Location : Decodable{
    let id: Int
    let country: String
    let city: String
    let address: String
    let postal_code: String
    let latitude: Double
    let longitude: Double
}
