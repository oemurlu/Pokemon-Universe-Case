//
//  PokemonService.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

final class PokemonService {
    
    static let shared = PokemonService()
    private let coreService = CoreService.shared
    
    init() {}
    
    func fetchPokemons(endPoint: PokemonEndpoint) async throws -> PokemonResponse {
        return try await coreService.makeRequest(url: endPoint.urlString, model: PokemonResponse.self)
    }
    
}
