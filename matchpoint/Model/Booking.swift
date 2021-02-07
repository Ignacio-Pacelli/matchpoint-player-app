//
//  Booking.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 27/1/21.
//

import CoreData

struct Booking: Decodable {
    let id: Int
    let startDate: Date?
    let endDate: Date?
    let price: Double
//    let owner: Player

//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case startDate = "startDate"
//        case endDate = "endDate"
//        case price = "price"
//        case owner = "owner"
//    }
}
