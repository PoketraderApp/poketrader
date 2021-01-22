//
//  PokemonList.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 19/01/21.
//

import Foundation

// MARK: - PokemonList
struct PokemonList: Codable {
    let count: Int
    var next: String?
    var previous: String?
    var results: [Result]
}

// MARK: - Result
struct Result:Codable {
    let name: String
    let url: String
}
