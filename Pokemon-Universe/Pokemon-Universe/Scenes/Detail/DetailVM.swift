//
//  DetailVM.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 28.03.2024.
//

import Foundation

protocol DetailViewModelInterface {
    var view: DetailViewControllerInterface? { get set }
    func viewDidLoad()
    func fetchDetails()
    func addPokemonToFavorites()
}

final class DetailVM {
    
    private let name: String
    weak var view: DetailViewControllerInterface?
    var imageUrl: String?
    
    init(name: String) {
        self.name = name
    }
}

extension DetailVM: DetailViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
        view?.configureFavoriteButton()
        view?.configureAvatarImageView()
        view?.configureTitle(pokemonName: self.name)
        view?.configureExpandableView()
        fetchDetails()
    }
    
    func fetchDetails() {
        Task {
            do {
                let pokemon = try await PokemonService.shared.fetchPokemonDetail(endpoint: .getPokemonByName(name: self.name))
                handlePokemon(with: pokemon)
            } catch {
                print(error)
            }
        }
    }
    
    private func handlePokemon(with pokemon: PokemonDetail) {
        let skills = pokemon.abilities?.compactMap { $0.ability?.name }
        let image = pokemon.sprites?.frontDefault ?? ""
        
        let weight = pokemon.weight
        let height = pokemon.height
        
        let stats: [(name: String, value: Int)] = pokemon.stats?.compactMap { statItem in
            guard let name = statItem.stat?.name, let value = statItem.base_stat else { return nil }
            return (name, value)
        } ?? []
        
        self.imageUrl = image //for userdefault
        
        view?.updateUI(imageUrl: image, skills: skills, weight: weight, height: height, stats: stats)
    }
    
    func addPokemonToFavorites() {
        let favoritePokemon = CombinedPokemon(name: self.name, image: self.imageUrl)
        
        UserDefaultsService.updateWith(favorite: favoritePokemon, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { // if the error is nil; success
                DispatchQueue.main.async {
                    self.view?.didReceiveError(title: "Success!", message: "You have successfully favorited this pokemon 🎉")
                }
                return
            }
            view?.didReceiveError(title: "Something went wrong", message: error.rawValue)
        }
    }
}


