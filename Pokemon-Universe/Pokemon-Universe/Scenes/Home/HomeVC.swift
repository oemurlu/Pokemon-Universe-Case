//
//  HomeVC.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import UIKit

protocol HomeViewControllerInterface: AnyObject {
    func configureVC()
    func configureCollectionView()
    func reloadCollectionViewOnMainThread()
}

final class HomeVC: UIViewController {

    private var collectionView: UICollectionView!
    let viewModel = HomeVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
}

extension HomeVC: HomeViewControllerInterface {
    func configureVC() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Pokemons"
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        #warning("set bgcolor to .clear")
        
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: PokemonCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        collectionView.pinToEdgesOfSafeArea(of: view)
    }
    
    func reloadCollectionViewOnMainThread() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.combinedPokemonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.reuseID, for: indexPath) as! PokemonCell
        cell.set(pokemon: viewModel.combinedPokemonList[indexPath.item])
        return cell
    }
}
