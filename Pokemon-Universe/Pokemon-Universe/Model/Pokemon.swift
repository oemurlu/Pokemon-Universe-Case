//
//  Pokemon.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

struct Pokemon: Decodable {
    let name: String?
    let url: String?
}

struct PokemonResponse: Decodable {
    let next: String?
    let results: [Pokemon]?
}
