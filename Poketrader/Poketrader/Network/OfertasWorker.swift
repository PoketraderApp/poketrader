//
//  OfertasWorker.swift
//  Poketrader
//
//  Created by Paulo Vieira on 11/12/20.
//

import Foundation
import Firebase
import FirebaseFirestore

class OfertasWorker: GenericWorker {
    var ofersList = Ofertas()
    let db = Firestore.firestore()
    
    func loadAnuncios(completion: @escaping (Ofertas?, String?) -> ()) {
        self.ofersList.ofertas = []
        db.collection("anuncio").getDocuments { (query, err) in
            if let e = err {
                print("Deu ruim \(e)")
            } else {
                print("\(self.ofersList)")
                if let document = query?.documents {
                    for doc in document {
                        let data = doc.data()
                        if let userName = data["userName"] as? String, let nameText = data["name"] as? String, let urlText = data["url"] as? String, let gameText = data["game"] as? String, let obsText = data["obs"] as? String {
                            let officialArt = OfficialArtwork(imagePath: urlText)
                            let other = Other(dreamWorld: nil, officialArtwork: officialArt)
                            let sprites = Sprites(other: other)
                            let pokeData = PokeData(id: nil, name: nameText, sprites: sprites, stats: nil)
                            let pokemon = Pokemon(sprt: urlText, data: pokeData)
                            let newOfer = OfertaElement(game: gameText, pokemon: pokemon, observacoes: obsText, ofertaID: nil, nome: userName, email: nil, telefone: nil)
                            self.ofersList.ofertas?.append(newOfer)
                        }
                    }
                }
                completion(self.ofersList, nil)
                print("Deu bom: \(String(describing: query))")
            }
        }
    }
    
    func loadAnunciosPorIUD(completion: @escaping (Ofertas?, String?) -> ()) {
        self.ofersList.ofertas = []
        db.collection("anuncio").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "").getDocuments { (query, err) in
            if let e = err {
                print("Deu ruim \(e)")
            } else {
                print("\(self.ofersList)")
                if let document = query?.documents {
                    for doc in document {
                        let data = doc.data()
                        if  let userName = data["userName"] as? String, let nameText = data["name"] as? String, let urlText = data["url"] as? String, let gameText = data["game"] as? String, let obsText = data["obs"] as? String {
                            let officialArt = OfficialArtwork(imagePath: urlText)
                            let other = Other(dreamWorld: nil, officialArtwork: officialArt)
                            let sprites = Sprites(other: other)
                            let pokeData = PokeData(id: nil, name: nameText, sprites: sprites, stats: nil)
                            let pokemon = Pokemon(sprt: urlText, data: pokeData)
                            let newOfer = OfertaElement(game: gameText, pokemon: pokemon, observacoes: obsText, ofertaID: nil, nome: userName, email: Auth.auth().currentUser?.email, telefone: Auth.auth().currentUser?.phoneNumber)
                            self.ofersList.ofertas?.append(newOfer)
                        }
                    }
                }
                completion(self.ofersList, nil)
                print("Deu bom: \(String(describing: query))")
            }
        }
    }
    
    func loadOfertas(completion: @escaping (Ofertas?, String?) -> ()) {
        if let path = Bundle.main.path(forResource: "ofertas", ofType: "json") {
            do {
                let ofertas = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let ofertasList = try JSONDecoder().decode(Ofertas.self, from: ofertas)
                completion(ofertasList, nil)
            } catch {
                completion(nil, "Don't fail me again")
            }
        }
    }
}
