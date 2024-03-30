//
//  CoreService.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

final class CoreService {
    static let shared = CoreService()

    private init() {}
    
    func makeRequest<T: Decodable>(url urlString: String, model: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else { throw NetworkError.badURL }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodingError
        }
    }
}
