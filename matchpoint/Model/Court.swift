//
//  Court.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 27/1/21.
//
import CoreData

struct Court: Decodable {
    let id: CLong
    let pricePerHour: Double
    let name: String
    let openingTime: Date?
    let closingTime: Date?
}
