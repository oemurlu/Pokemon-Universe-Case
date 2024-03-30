//
//  MockPokemonService.swift
//  Pokemon-UniverseTests
//
//  Created by Osman Emre Ömürlü on 30.03.2024.
//

import Foundation
@testable import Pokemon_Universe

#warning("To test A, the 'final' keyword in B must be removed. Actually I should have written with protocols.")

class MockPokemonService: PokemonService {
    var mockPokemonsResponse: PokemonResponse?
    var mockPokemonDetailResponse: PokemonDetail?
    var fetchPokemonsCalled = false
    var fetchPokemonDetailCalled = false

    override func fetchPokemons(endPoint: PokemonEndpoint) async throws -> PokemonResponse {
        fetchPokemonsCalled = true
        if let mockResponse = mockPokemonsResponse {
            return mockResponse
        } else {
            throw NetworkError.decodingError
        }
    }

    override func fetchPokemonDetail(endpoint: PokemonEndpoint) async throws -> PokemonDetail {
        fetchPokemonDetailCalled = true
        if let mockResponse = mockPokemonDetailResponse {
            return mockResponse
        } else {
            throw NetworkError.decodingError
        }
    }
}

// data section

extension MockPokemonService {
    static var samplePokemonResponse: PokemonResponse {
        return PokemonResponse(
            next: "https://pokeapi.co/api/v2/pokemon/?offset=10&limit=10",
            results: [
                Pokemon(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/"),
                Pokemon(name: "ivysaur", url: "https://pokeapi.co/api/v2/pokemon/2/"),
                Pokemon(name: "venusaur", url: "https://pokeapi.co/api/v2/pokemon/3/"),
            ]
        )
    }

    static var samplePokemonDetail: PokemonDetail {
        return PokemonDetail(
            abilities: [
                AbilityItem(ability: Ability(name: "overgrow", url: "https://pokeapi.co/api/v2/ability/65/")),
                AbilityItem(ability: Ability(name: "chlorophyll", url: "https://pokeapi.co/api/v2/ability/34/")),
            ],
            sprites: PokemonImage(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"),
            weight: 69,
            height: 7,
            stats: [
                StatsItem(base_stat: 45, stat: Stat(name: "hp")),
                StatsItem(base_stat: 49, stat: Stat(name: "attack")),
            ]
        )
    }
}


