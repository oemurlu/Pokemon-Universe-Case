//
//  FavoritesVC.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import UIKit

protocol FavoritesViewControllerInterface: AnyObject {
    func configureVC()
    func configureCollectionView()
    func reloadCollectionViewOnMainThread()
    func callLoadingView()
    func dismissLoadingView()
}

class FavoritesVC: UIViewController {
    
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
        configureCollectionView()
    }
}

extension FavoritesVC: FavoritesViewControllerInterface {
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createFavoritesFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.pinToEdgesOfSafeArea(of: view)
    }
    
    func reloadCollectionViewOnMainThread() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func callLoadingView() {
        view.showLoadingView()
    }
    
    func dismissLoadingView() {
        view.hideLoadingView()
    }
}

extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        cell.set(pokemon: CombinedPokemon(name: "test123", image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png"))
//        cell.set(pokemon: CombinedPokemon(name: "test 234", image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"))
        return cell
    }
}
