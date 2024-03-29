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
    func pokemonDidSelected(at index: IndexPath)
}

final class HomeVM {
    weak var view: HomeViewControllerInterface?
    var pokemonsList = [Pokemon]()
    var combinedPokemonList = [CombinedPokemon]()
    
    private var canLoadMorePages = true
    private var offset = 0 // for paging
    private var limit = 15 // item count per request
    private var isLoading = false
    
}

extension HomeVM: HomeViewModelInterface {
    func viewDidLoad() {
        view?.callLoadingView()
        view?.configureVC()
        view?.configureCollectionView()
        fetchPokemons()
    }
    
    func fetchPokemons() {
        // fetch pokemons if exists
        guard canLoadMorePages, !isLoading else { return } // finish if it's already loading or there are no more pages
        isLoading = true // fetch islemini baslattik.
        
        Task {
            // defer block is executed whether the code is successful or not
            defer { self.isLoading = false }
            do {
                let pokemonResponse = try await PokemonService.shared.fetchPokemons(endPoint: .getPokemons(offset: offset, limit: limit))
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
        // pagination check
        if pokemonResponse.next != nil {
            canLoadMorePages = true
            offset += limit
        } else {
            canLoadMorePages = false
        }
        
        guard let _ = pokemonResponse.results else { return }
        var newCombinedPokemons = [CombinedPokemon]()

        // create combined array with images and names
        let pokemonNames = pokemonResponse.results?.compactMap { $0.name} ?? []
        let dispatchGroup = DispatchGroup()
        for pokemonName in pokemonNames {
            dispatchGroup.enter()
            do {
                let pokemonDetail = try await PokemonService.shared.fetchPokemonDetail(endpoint: .getPokemonByName(name: pokemonName))
                let combinedPokemon = CombinedPokemon(name: pokemonName, image: pokemonDetail.sprites?.frontDefault)
                newCombinedPokemons.append(combinedPokemon)
                dispatchGroup.leave()
            } catch {
                print("error while fetching pokemonDetail: \(error.localizedDescription)")
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) {
            self.view?.dismissLoadingView()
            self.view?.reloadCollectionViewOnMainThread()
            self.combinedPokemonList.append(contentsOf: newCombinedPokemons)
        }
    }
    
    func pokemonDidSelected(at index: IndexPath) {
        guard let pokemonName = combinedPokemonList[index.item].name else { return }
        view?.navigateToDetail(with: pokemonName)
    }
}
