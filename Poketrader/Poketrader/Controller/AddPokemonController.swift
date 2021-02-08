//
//  AddPokemonController.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 22/01/21.
//

import Foundation
import Firebase

class AddPokemonController {
    private var pokemon: Pokemon?
    
    func savePokemon(name: String?,telefone: String?, url: String?, game: String?, nv: String?, hp: String?, def: String?, ata: String?, vel: String?, defSp: String?, ataSp: String?, obs: String?) {
        OfertasWorker().saveOffer(name: name, telefone: telefone, url: url, game: game, nv: nv, hp: hp, def: def, ata: ata, vel: vel, defSp: defSp, ataSp: ataSp, obs: obs)
    }
    
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
