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
                print("Deu bom: \(query)")
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
                        
                        //let capitalCities = db.collection("cities").whereField("capital", isEqualTo: true)
                        
                        if let nameText = data["name"] as? String, let urlText = data["url"] as? String, let _ = data["game"] as? String, let obsText = data["obs"] as? String {
                            
                            let officialArt = OfficialArtwork(imagePath: urlText)
                            let other = Other(dreamWorld: nil, officialArtwork: officialArt)
                            let sprites = Sprites(other: other)
                            let pokeData = PokeData(id: nil, name: nameText, sprites: sprites, stats: nil)
                            let pokemon = Pokemon(sprt: urlText, data: pokeData)
                            let newOfer = OfertaElement(pokemon: pokemon, observacoes: obsText, ofertaID: nil, nome: nil, email: nil, telefone: nil)
                            
                            self.ofersList.ofertas?.append(newOfer)
                            
                            
                        }
                    }
                }
                completion(self.ofersList, nil)
                print("Deu bom: \(query)")
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
    
    func getOferta(id: Int, completion: @escaping completion<OfertaElement?>) {
        if let path = Bundle.main.path(forResource: "ofertas", ofType: "json") {
            do {
                let ofertas = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let ofertasList = try JSONDecoder().decode(Ofertas.self, from: ofertas)
                let lista = ofertasList.ofertas?.filter({$0.ofertaID == id})
                
                let oferta = lista?.first
                completion(oferta, nil)
            } catch {
                completion(nil, "Don't fail me again")
            }
        }
    }
    
    func getOfertaMock(ofertaID: Int, completion: @escaping completion<Ofertas?>) {
        if let path = Bundle.main.path(forResource: "ofertas", ofType: "json") {
            do {
                let ofertas = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let ofertasList = try JSONDecoder().decode(Ofertas.self, from: ofertas)
                let lista = ofertasList.ofertas?.filter({$0.ofertaID == ofertaID})
                
                // MARK: - Avaliar
                // Ajustar tipo
                // Sem o Ofertas(ofertas: lista) acaba-se criando um [OfertaElement]
                // -> Verificar lógica
                let _ofertas = Ofertas(ofertas: lista)
                completion(_ofertas, nil)
            } catch {
                completion(nil, "Don't fail me again")
            }
        }
    }
    
}
