//
//  University.swift
//  UniversitiesApp
//
//  Created by AmrFawaz on 02/05/2024.
//

import Foundation

struct University: Codable, Identifiable {
    let id: String = NSUUID().uuidString
    let name: String
    let state: String?
    let country: String
    let countryCode: String
    let webPages: [String]

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case state = "state-province"
        case countryCode = "alpha_two_code"
        case webPages = "web_pages"
    }
}
