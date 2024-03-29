//
//  PUAvatarImageView.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import UIKit

class PUAvatarImageView: UIImageView {
    
    private var currentTask: Task<Void, Never>?
    let cache = PokemonService.shared.cache
    let placeHolderImage = UIImage(systemName: "arrow.counterclockwise")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadImage(fromURL url: String) {
        currentTask?.cancel()
        
        currentTask = Task {
            showLoadingView()
            let downloadedImage = await PokemonService.shared.downloadImage(from: url)
            DispatchQueue.main.async {
                if !Task.isCancelled {
                    self.image = downloadedImage
                    self.hideLoadingView()
                }
            }
        }
    }
    
    func cancelImageDownload() {
        currentTask?.cancel()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        tintColor = .placeholderText
        contentMode = .scaleToFill
    }
}
