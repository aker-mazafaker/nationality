//
//  Model.swift
//  16.08classwork
//
//  Created by Akerke on 30.08.2023.
//

import Foundation

// MARK: - Welcome
struct NationResponse: Codable {
    let count: Int
    let name: String
    let country: [Country]
}

// MARK: - Country
struct Country: Codable {
    let countryID: String
    let probability: Double

    enum CodingKeys: String, CodingKey {
        case countryID = "country_id"
        case probability
    }
}
