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
    
    var id: String?
    
    var game: String?
    // Parte do Pokémon
    var pokemon: Pokemon?
    
    // Parte do anúncio
    var observacoes: String?
    var ofertaID: Int?
    
    // Parte do anunciante, mudar depois
    var nome: String?
    var email: String?
    var telefone: String?
    
}
