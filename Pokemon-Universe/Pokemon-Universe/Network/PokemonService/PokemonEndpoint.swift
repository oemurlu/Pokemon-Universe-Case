//
//  PokemonEndpoint.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

enum PokemonEndpoint {
    case getPokemons(offset: Int, limit: Int)
    case getPokemonByName(name: String)
    
    var urlString: String {
        switch self {
        case .getPokemons(let offset, let limit):
            return "\(Path.pokemons.rawValue)?offset=\(offset)&limit=\(limit)"
        case .getPokemonByName(name: let name):
            return "\(Path.pokemons.rawValue)/\(name)"
        }
        
    }
}

enum Path: String {
    case pokemons = "https://pokeapi.co/api/v2/pokemon/"
}
