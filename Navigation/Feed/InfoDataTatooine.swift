//
//  InfoDataTatooine.swift
//  Navigation
//
//  Created by Vladislav Green on 11/28/22.
//

import Foundation

struct Tatooine: Decodable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url
    }
}

struct TatooineResidentName: Decodable {
    let name: String
}
