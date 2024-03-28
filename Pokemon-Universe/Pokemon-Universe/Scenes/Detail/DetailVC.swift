//
//  DetailVC.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 28.03.2024.
//

import UIKit

protocol DetailViewControllerInterface: AnyObject {
    func configureVC()
    func configureAvatarImageView()
    func configureTitle(pokemonName: String)
    func configureSkillsLabel()
    func updateUI(imageUrl: String, skills: [String])
}

class DetailVC: UIViewController {

    var viewModel: DetailVM!
    
    private var avatarImageView: PUAvatarImageView!
    private var pokemonNameLabel: PUTitleLabel!
    private var skillsLabel: PUTitleLabel!
    
    private let padding: CGFloat = 20
    
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        viewModel = DetailVM(name: name)
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
    
    func configureAvatarImageView() {
        avatarImageView = PUAvatarImageView(frame: .zero)
        view.addSubview(avatarImageView)
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 2 * padding),
            avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -2 * padding),
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
    
    
    func configureSkillsLabel() {
        skillsLabel = PUTitleLabel(fontSize: 20)
        view.addSubview(skillsLabel)
        
        skillsLabel.text = "Skills: ..."
        
        NSLayoutConstraint.activate([
            skillsLabel.topAnchor.constraint(equalTo: pokemonNameLabel.bottomAnchor, constant: padding),
            skillsLabel.leadingAnchor.constraint(equalTo: pokemonNameLabel.leadingAnchor),
            skillsLabel.trailingAnchor.constraint(equalTo: pokemonNameLabel.trailingAnchor),
            skillsLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func updateUI(imageUrl: String, skills: [String]) {
        DispatchQueue.main.async {
            self.avatarImageView.downloadImage(fromURL: imageUrl)
            
            let skillsText = skills.joined(separator: ", ")
            self.skillsLabel.text = "Skills: \(skillsText)"
        }
    }
}
