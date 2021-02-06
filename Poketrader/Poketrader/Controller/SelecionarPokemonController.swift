//
//  SelecionarPokemonController.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 20/01/21.
//

import Foundation

class SelecionarPokemonController{
    private var pokemonList: PokemonList?
    private var pokemonListWithAllPokemons: PokemonList?
    
    var numberOfRows: Int {
        return pokemonList?.results.count ?? 0
    }
    
    var numberOfPokemonsInDatabase: Int {
        return pokemonList?.count ?? 0
    }
    
    func getNomePokemon(at posicao: Int) -> String? {
        return pokemonList?.results[posicao].name.capitalizingFirstLetter()
        
    }
    
    func nextURL() -> String?{
        return self.pokemonList?.next
    }
    
    
    func getTwentyPokemons (url: String? = nil, completion: @escaping (Bool, String?) -> ()) {
        
        if let _url = url {
            PokemonWork().getTwentyPokemons(urlNext: _url) { (pokemonList, erro) in
                if erro == nil {
                    let results: [Result] = pokemonList?.results ?? []
                    for result in results {
                        self.pokemonList?.results.append(result)
                    }
                    self.pokemonList?.next = pokemonList?.next
                }
                else{
                    completion(false, "deu ruim ao pegar os próximos 20 pokemons")
                }
            }
        }
        else{
            PokemonWork().getTwentyPokemons(){ (pokemonList, erro) in
                if erro == nil {
                    self.pokemonList = pokemonList
                    completion(true, "")
                }
                else{
                    completion(false, "deu ruim ao pegar os primeiros 20 pokemons")
                }
            }
        }

    }
    
    
    func loadPokemon(nome: String, completion: @escaping (Bool, Pokemon?)-> ()) {
        PokemonWork().getPokemonURLSession(nome: nome){ (pokemon, erro) in
            if erro == nil {

                completion(true, pokemon)
            }
            else {
                completion(false, nil)
            }
            
        }
    }
    
    func teste(){
        print(self.pokemonList?.results ?? "erro")
    }
    
    func calculateIndexPathsToReload(from newPokemons: [PokemonList]) -> [IndexPath] {
        let startIndex = self.pokemonList?.count ?? 20 - newPokemons.count
        let endIndex = startIndex + newPokemons.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}
