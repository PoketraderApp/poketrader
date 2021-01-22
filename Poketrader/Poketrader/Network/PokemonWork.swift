//
//  PokemonWork.swift
//  Poketrader
//
//  Created by Paulo Vieira on 08/12/20.
//

import Foundation
import Alamofire

class PokemonWork: GenericWorker {
    let urlString: String = "https://pokeapi.co/api/v2/pokemon/"
    let limit: String = "?limit="
    
    func getPokemon(nome: String, completion: @escaping completion<Pokemon?>) {
        let url: URL? = URL(string: urlString + nome)
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = Method.get.rawValue
            
            AF.request(request).responseJSON { (response) in

                if response.response?.statusCode == 200 {
                    do {
                        let pokemonData = try JSONDecoder().decode(PokeData.self, from: response.data ?? Data())
                        let pokemon = Pokemon(data: pokemonData)
                        completion(pokemon, nil)
                    } catch {
                        // deu ruim no parse
                        completion(nil, "deu ruim")
                    }
                } else {
                    // deu ruim no request
                    completion(nil, "deu ruim")
                }
            }
            
        }
    }
    
    func getPokemonURLSession(nome: String, completion: @escaping completion<Pokemon?>) {
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
    
    func getTwentyPokemons(urlNext:String? = nil, completion: @escaping completion<PokemonList?>) {
        let session: URLSession = URLSession.shared
        var url: URL? = URL(string: urlString)
        
        if let _urlNext = urlNext {
            url = URL(string: _urlNext)
        }
        
        if let _url = url {
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
                do{
                    let numberOfPokemons = try JSONDecoder().decode(PokemonList.self, from: data ?? Data())
                    completion(numberOfPokemons, nil)
                }
                catch{
                    completion(nil, nil)
                }
            
            }
            task.resume()
        }
    }
    
}
