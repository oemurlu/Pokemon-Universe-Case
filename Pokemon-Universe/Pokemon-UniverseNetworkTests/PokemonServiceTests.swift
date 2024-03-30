//
//  PokemonServiceTests.swift
//  Pokemon-UniverseTests
//
//  Created by Osman Emre Ömürlü on 30.03.2024.
//

// PokemonServiceTests.swift

import XCTest
@testable import Pokemon_Universe

class PokemonServiceTests: XCTestCase {

    var mockService: MockPokemonService!
    
    override func setUp() {
        super.setUp()
        mockService = MockPokemonService()
        mockService.mockPokemonsResponse = MockPokemonService.samplePokemonResponse
        mockService.mockPokemonDetailResponse = MockPokemonService.samplePokemonDetail
    }
    
    override func tearDown() {
        mockService = nil
        super.tearDown()
    }
    
    func testFetchPokemons() async throws {
        let response = try await mockService.fetchPokemons(endPoint: .getPokemons(offset: 0, limit: 10))
        
        XCTAssertTrue(mockService.fetchPokemonsCalled)
        XCTAssertEqual(response.results?.count, 3)
        XCTAssertEqual(response.results?[0].name, "bulbasaur")
        XCTAssertEqual(response.results?[1].name, "ivysaur")
        XCTAssertEqual(response.results?[2].name, "venusaur")
    }
    
    func testFetchPokemonDetail() async throws {
        let detail = try await mockService.fetchPokemonDetail(endpoint: .getPokemonByName(name: "bulbasaur"))
        
        XCTAssertTrue(mockService.fetchPokemonDetailCalled)
        XCTAssertEqual(detail.abilities?.count, 2)
        XCTAssertEqual(detail.abilities?[0].ability?.name, "overgrow")
        XCTAssertEqual(detail.abilities?[1].ability?.name, "chlorophyll")
        XCTAssertEqual(detail.sprites?.frontDefault, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
        XCTAssertEqual(detail.weight, 69)
        XCTAssertEqual(detail.height, 7)
        XCTAssertEqual(detail.stats?.count, 2)
        XCTAssertEqual(detail.stats?[0].base_stat, 45)
        XCTAssertEqual(detail.stats?[1].base_stat, 49)
    }
}
