//
//  News.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 7/2/21.
//

import Foundation

struct News: Decodable {
    let id: Int
    let title : String
    let subtitle: String
    let content: String
    let pictureUrl: String?
    let videoUrl: String?
    let club: Club
}
