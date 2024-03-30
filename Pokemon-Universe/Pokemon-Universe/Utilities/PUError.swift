//
//  PUError.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 30.03.2024.
//

import Foundation

enum PUError: String, Error {
    case unableToFavorite = "There was an error favoriting this pokemon. Please try again."
    case alreadyInFavorites = "You've already favorited this pokemon. You must really like them!"
}
