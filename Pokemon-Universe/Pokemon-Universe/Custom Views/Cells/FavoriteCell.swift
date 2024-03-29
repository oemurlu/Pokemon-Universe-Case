//
//  FavoriteCell.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 29.03.2024.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    static let reuseID = "FavoriteCell"
    
    let avatarImageView = PUAvatarImageView(frame: .zero)
    let pokemonNameLabel = PUTitleLabel(fontSize: 24)
    let unfavoriteButton = UIButton(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.cancelImageDownload()
    }
    
    func set(pokemon: CombinedPokemon) {
        DispatchQueue.main.async {
            self.avatarImageView.downloadImage(fromURL: pokemon.image ?? "")
            self.pokemonNameLabel.text = pokemon.name?.capitalized
        }
    }
    
    private func configure() {
        addSubviews(avatarImageView, pokemonNameLabel, unfavoriteButton)
        let padding: CGFloat = 8
        
        pokemonNameLabel.textAlignment = .center
        
        layer.borderColor = UIColor.secondaryLabel.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold, scale: .large)
        let heartImage = UIImage(systemName: "heart", withConfiguration: largeConfig)
        unfavoriteButton.setImage(heartImage, for: .normal)
        unfavoriteButton.tintColor = .systemRed
        unfavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 2 * padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            
            pokemonNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            pokemonNameLabel.trailingAnchor.constraint(equalTo: avatarImageView.trailingAnchor),
            pokemonNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4 * padding),
            pokemonNameLabel.heightAnchor.constraint(equalToConstant: 28),
            
            unfavoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            unfavoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            unfavoriteButton.widthAnchor.constraint(equalToConstant: 30),
            unfavoriteButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
