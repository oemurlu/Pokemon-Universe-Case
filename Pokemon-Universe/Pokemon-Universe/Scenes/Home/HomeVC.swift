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
    func navigateToDetail(with name: String)
    func callLoadingView()
    func dismissLoadingView()
}

final class HomeVC: UIViewController {
    
    private var collectionView: UICollectionView!
    private var viewModel: HomeVM!
    
    init(viewModel: HomeVM) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = HomeVM()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        
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
    
    func navigateToDetail(with name: String) {
        let detailVC = DetailVC(name: name)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func callLoadingView() {
        DispatchQueue.main.async {
            self.view.showLoadingViewForNewPokemonsLoading()
        }
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.view.hideLoadingViewForNewPokemonsDidLoad()
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.pokemonDidSelected(at: indexPath)
    }
}

extension HomeVC: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY >= contentHeight - (4 * height) {
            viewModel.fetchPokemons()
        }
    }
}
