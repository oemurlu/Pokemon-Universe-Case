//
//  PokemonResponse.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

struct PokemonResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Pokemon]?
    
    var _count: Int {
        count ?? 0
    }
}
