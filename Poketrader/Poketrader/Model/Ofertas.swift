//
//  File.swift
//  Poketrader
//
//  Created by David Souza on 11/11/2020.
//

import Foundation

struct Ofertas: Codable {
    let ofertas: [OfertaElement]
}

struct OfertaElement: Codable {
    let pokemon, imagem, numero, jogador: String
}
