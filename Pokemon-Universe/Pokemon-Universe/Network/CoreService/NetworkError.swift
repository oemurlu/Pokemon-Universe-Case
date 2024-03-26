//
//  NetworkError.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

enum NetworkError: String, Error {
    case badURL = "Invalid url. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case decodingError = "The data received from the server was invalid. Please try again."
}
