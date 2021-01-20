//
//  PokemonList.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 19/01/21.
//

import Foundation

// MARK: - PokemonList
struct PokemonList {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]
}

// MARK: - Result
struct Result {
    let name: String
    let url: String
}
