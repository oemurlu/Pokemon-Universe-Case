//
//  PokemonDetail.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

struct PokemonDetail: Decodable {
    let abilities: [AbilityItem]?
    let sprites: PokemonImage?
    let weight: Int?
    let height: Int?
}

struct AbilityItem: Decodable {
    let ability: Ability?
}

struct Ability: Decodable {
    let name: String?
    let url: String?
}

struct PokemonImage: Decodable {
    let frontDefault: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
