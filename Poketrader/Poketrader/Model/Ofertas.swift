//
//  Ofertas.swift
//  Poketrader
//
//  Created by David Souza on 11/11/2020.
//

import Foundation


// MARK: - Lista de ofertas
struct Ofertas: Codable {
    var ofertas: [OfertaElement]?
}

// MARK: - Oferta
struct OfertaElement: Codable {
    var pokemon, imagem, numero, jogador: String?
    var Stats: PokemonStats?
}

// MARK: - Struct para carregar os status do Pokémon
struct PokemonStats: Codable {
    var hp, attack, defence, sp_attack, sp_defence, speed: Int?
}
