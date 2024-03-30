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
    func didReceiveError(title: String, message: String)
    func deleteFavoritedItem(at indexPath: IndexPath)
}

final class FavoritesVC: UIViewController {
    
    private var collectionView: UICollectionView!
    private var viewModel: FavoritesVM!

    init(viewModel: FavoritesVM) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
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
        collectionView.showsVerticalScrollIndicator = false
        
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
    
    func didReceiveError(title: String, message: String) {
        MakeAlert.alertMessage(title: title, message: message, style: .alert, vc: self)
    }
    
    func deleteFavoritedItem(at indexPath: IndexPath) {
        DispatchQueue.main.async {
            self.collectionView.deleteItems(at: [indexPath])
        }
    }
}

extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        cell.delegate = self
        cell.set(pokemon: viewModel.favorites[indexPath.item])
        return cell
    }
}

extension FavoritesVC: FavoriteCellDelegate {
    func cellRequestDelete(cell: FavoriteCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        self.viewModel.deleteCell(indexPath: indexPath)
    }
}
