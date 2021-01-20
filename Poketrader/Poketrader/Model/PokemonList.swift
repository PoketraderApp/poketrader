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
    let next: String?
    let previous: String?
    let results: [Result]
}

// MARK: - Result
struct Result:Codable {
    let name: String
    let url: String
}

//MARK: - OnlyCount

struct NumberOfPokemons: Codable {
    let count: Int
}
