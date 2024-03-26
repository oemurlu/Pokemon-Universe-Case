//
//  HomeVM.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

protocol HomeViewModelInterface {
    var view: HomeViewControllerInterface? { get set }
    func viewDidLoad()
    func fetchPokemons()
}

final class HomeVM {
    weak var view: HomeViewControllerInterface?
    var pokemonsList = [Pokemon]()
    
    var combinedPokemonList = [CombinedPokemon]()
}

extension HomeVM: HomeViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
        fetchPokemons()
    }
    
    func fetchPokemons() {
        Task {
            do {
                let pokemonResponse = try await PokemonService.shared.fetchPokemons(endPoint: .getPokemons(offset: 0, limit: 10))
                await handlePokemonResponse(with: pokemonResponse)
            } catch {
                if let puError = error as? NetworkError {
                    print("pu error: \(puError.localizedDescription)")
                } else {
                    print("defauilt error: \(error)")
                }
            }
        }
    }
    
    private func handlePokemonResponse(with pokemonResponse: PokemonResponse) async {
        let pokemonNames = pokemonResponse.results?.compactMap { $0.name} ?? []
        let dispatchGroup = DispatchGroup()
        for pokemonName in pokemonNames {
            dispatchGroup.enter()
            do {
                let pokemonDetail = try await PokemonService.shared.fetchPokemonDetail(endpoint: .getPokemonByName(name: pokemonName))
                let combinedPokemon = CombinedPokemon(name: pokemonName, image: pokemonDetail.sprites?.frontDefault)
                self.combinedPokemonList.append(combinedPokemon)
                dispatchGroup.leave()
            } catch {
                print("error while fetching pokemonDetail: \(error.localizedDescription)")
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.view?.reloadCollectionViewOnMainThread()
        }
    }
}
