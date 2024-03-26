//
//  PokemonService.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

//import Foundation
import UIKit

final class PokemonService {
    
    static let shared = PokemonService()
    private let coreService = CoreService.shared
    let cache = NSCache<NSString, UIImage>()
    
    init() {}
    
    func fetchPokemons(endPoint: PokemonEndpoint) async throws -> PokemonResponse {
        return try await coreService.makeRequest(url: endPoint.urlString, model: PokemonResponse.self)
    }
    
    func fetchPokemonDetail(endpoint: PokemonEndpoint) async throws -> PokemonDetail {
        return try await coreService.makeRequest(url: endpoint.urlString, model: PokemonDetail.self)
    }
    
    // bir hata olusursa nil return edecem ve placeholder set edilecek.
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
