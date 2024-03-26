//
//  PokemonEndpoint.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

enum PokemonEndpoint {
    case getPokemons(offset: Int, limit: Int)
    
    var urlString: String {
        switch self {
        case .getPokemons(let offset, let limit):
            return "\(Path.pokemons.rawValue)?offset=\(offset)&limit=\(limit)"
        }
    }
}

enum Path: String {
    case pokemons = "https://pokeapi.co/api/v2/pokemon/"
}
