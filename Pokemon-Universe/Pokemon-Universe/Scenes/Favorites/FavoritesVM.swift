//
//  FavoritesVM.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 30.03.2024.
//

import Foundation

protocol FavoritesViewModelInterface {
    var view: FavoritesViewControllerInterface? { get set }
    func viewDidLoad()
    func viewWillAppear()
    func getFavorites()
    func handleFavorites(with favorites: [CombinedPokemon])
    func deleteCell(indexPath: IndexPath)
}

final class FavoritesVM {
    weak var view: FavoritesViewControllerInterface?
    var favorites: [CombinedPokemon] = []
}

extension FavoritesVM: FavoritesViewModelInterface {
    
    func viewDidLoad() {
        view?.configureVC()
        view?.configureCollectionView()
    }
    
    func viewWillAppear() {
        getFavorites()
    }
    
    func getFavorites() {
        UserDefaultsService.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.handleFavorites(with: favorites)
            case .failure(let error):
                DispatchQueue.main.async {
                    self.view?.didReceiveError(title: "Something went wrong", message: error.rawValue)
                }
            }
        }
    }
    
    func handleFavorites(with favorites: [CombinedPokemon]) {
        if favorites.isEmpty {
            view?.didReceiveError(title: "No favorites?", message: "Add one on the Pokemons screen!")
        } else {
            self.favorites = favorites
            self.view?.reloadCollectionViewOnMainThread()
        }
    }
    
    func deleteCell(indexPath: IndexPath) {
        UserDefaultsService.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                view?.deleteFavoritedItem(at: indexPath)
                
                if self.favorites.isEmpty {
                    view?.didReceiveError(title: "No favorites?", message: "Add one on the Pokemons screen!")
                }
                
                return
            }
            view?.didReceiveError(title: "Unable to remove", message: error.rawValue)
        }
    }
}
