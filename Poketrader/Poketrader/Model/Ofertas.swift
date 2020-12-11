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
    
// MARK: - Lista de ofertas
struct OfertaElement: Codable {
    var ofertaID: String?
    var pkmn: Pokemon?
}
