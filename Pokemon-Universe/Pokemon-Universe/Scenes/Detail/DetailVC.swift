//
//  DetailVC.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 28.03.2024.
//

import UIKit

protocol DetailViewControllerInterface: AnyObject {
    func configureVC()
    func configureFavoriteButton()
    func configureAvatarImageView()
    func configureTitle(pokemonName: String)
    func configureExpandableView()
    func updateUI(imageUrl: String, skills: [String]?, weight: Int?, height: Int?, stats: [(name: String, value: Int)]?)
    func didReceiveError(title: String, message: String)
}

final class DetailVC: UIViewController {
    
    var viewModel: DetailVM!
    
    private var expandableView: UIView!
    private var avatarImageView: PUAvatarImageView!
    private var pokemonNameLabel: PUTitleLabel!
    private var favoriteButton: UIButton!
    
    private let padding: CGFloat = 20
    
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = DetailVM(name: name)
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

extension DetailVC: DetailViewControllerInterface {
    func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    func configureFavoriteButton() {
        let favoriteButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc func addButtonTapped() {
        viewModel.addPokemonToFavorites()
    }
    
    func configureAvatarImageView() {
        avatarImageView = PUAvatarImageView(frame: .zero)
        view.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding / 2),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2 * padding),
            avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -3 * padding),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor, multiplier: 1),
        ])
    }
    
    func configureTitle(pokemonName: String) {
        pokemonNameLabel = PUTitleLabel(fontSize: 28)
        view.addSubview(pokemonNameLabel)
        
        pokemonNameLabel.text = pokemonName.capitalized
        pokemonNameLabel.textAlignment = .center
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            pokemonNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            pokemonNameLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    func configureExpandableView() {
        expandableView = UIView()
        view.addSubview(expandableView)
        expandableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            expandableView.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: padding / 2),
            expandableView.leadingAnchor.constraint(equalTo: pokemonNameLabel.leadingAnchor),
            expandableView.trailingAnchor.constraint(equalTo: pokemonNameLabel.trailingAnchor),
            expandableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        DispatchQueue.main.async {
            self.addChild(childVC)
            containerView.addSubview(childVC.view)
            childVC.view.frame = containerView.bounds
            childVC.didMove(toParent: self)
        }
    }
    
    func updateUI(imageUrl: String, skills: [String]?, weight: Int?, height: Int?, stats: [(name: String, value: Int)]?) {
        DispatchQueue.main.async {
            self.avatarImageView.downloadImage(fromURL: imageUrl)
            let expandVC = ExpandableVC(skills: skills, weight: weight, height: height, stats: stats)
            self.add(childVC: expandVC, to: self.expandableView)
        }
    }
    
    func didReceiveError(title: String, message: String) {
        MakeAlert.alertMessage(title: title, message: message, style: .alert, vc: self)
    }
}
