//
//  AddPokemonController.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 22/01/21.
//

import Foundation

class AddPokemonController {
    private var pokemon: Pokemon?
    
    var pokemonURLImage: String {
        return self.pokemon?.sprite ?? ""
    }
    
    func getPokemonData(nomePokemon: String, completion: @escaping (Bool, String?) -> ()){
        PokemonWork().getPokemon(nome: nomePokemon){ (pokemon, erro) in
            if erro == nil {
                self.pokemon = pokemon
                completion(true, "")
            }
            else{
                completion(false, "Deu ruim ao pegas as infos do \(nomePokemon)")
            }
        }
    }
    
    func getPokemonInfoTeste() -> Pokemon?{
        return self.pokemon
    }
    
}