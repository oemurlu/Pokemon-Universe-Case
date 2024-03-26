//
//  PokemonCell.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import UIKit

final class PokemonCell: UICollectionViewCell {
    static let reuseID = "PokemonCell"
    
    let avatarImageView = PUAvatarImageView(frame: .zero)
    let pokemonNameLabel = PUTitleLabel(fontSize: 20)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(pokemon: CombinedPokemon) {
        DispatchQueue.main.async {
            self.avatarImageView.downloadImage(fromURL: pokemon.image ?? "")
            self.pokemonNameLabel.text = pokemon.name
        }
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, pokemonNameLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3 * padding),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            avatarImageView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 4/5),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            pokemonNameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            pokemonNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor, constant: CGFloat.deviceWidth / 9),
            pokemonNameLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = 20
    }
}
