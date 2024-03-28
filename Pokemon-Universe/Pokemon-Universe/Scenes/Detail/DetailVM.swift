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
}

class DetailVM {
    
    private let name: String
    weak var view: DetailViewControllerInterface?
    
    init(name: String) {
        self.name = name
    }
}

extension DetailVM: DetailViewModelInterface {
    func viewDidLoad() {
        view?.configureVC()
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
        view?.updateUI(imageUrl: image, skills: skills, weight: weight, height: height)
    }
}


