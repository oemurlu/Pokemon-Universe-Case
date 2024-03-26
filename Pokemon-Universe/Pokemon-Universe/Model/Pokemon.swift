//
//  Pokemon.swift
//  Pokemon-Universe
//
//  Created by Osman Emre Ömürlü on 26.03.2024.
//

import Foundation

struct Pokemon: Decodable {
    let name: String?
    let url: String?
    
    var _name: String { name ?? "N/A" }
    var _url: String { url ?? "N/A" }
}
