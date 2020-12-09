//
//  NetworkService.swift
//  Poketrader
//
//  Created by Paulo Vieira on 08/12/20.
//

import Foundation

class NetworkService {
    typealias completion <T> = (_ result: T, _ failure: String?) -> Void
    let urlString: String = "https://pokeapi.co/api/v2/pokemon/"
    
    func getPokemon(nome: String, completion: @escaping completion<Pokemon?>) {
        let session: URLSession = URLSession.init(configuration: .default)
        let url: URL? = URL(string: urlString + nome)
        if let url = url {
            let task: URLSessionTask = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    // deu ruim
                    completion(nil, "deu ruim")
                    return
                }
                if let data = data {
                    do {
                        let pokemonData = try JSONDecoder().decode(PokeData.self, from: data)
                        let pokemon = Pokemon(data: pokemonData)
                        completion(pokemon, nil)
                    } catch {
                        // deu ruim
                        completion(nil, "deu ruim")
                        return
                    }
                }
            }
            task.resume()
        }
    }
}
