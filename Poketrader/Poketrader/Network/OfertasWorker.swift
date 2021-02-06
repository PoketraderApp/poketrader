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
    
    func updateOffer(offer: OfertaElement, obs: String) {
        let ref = db.collection("anuncio").document(offer.id!)
        ref.updateData([
            "obs": obs
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func saveOffer(name: String?, url: String?, game: String?, obs: String?) {
        if let userData = Auth.auth().currentUser {
            let db = Firestore.firestore()
            var ref: DocumentReference? = nil
            ref = db.collection("anuncio").addDocument(data: ["id": ref?.documentID ?? "No Id", "userName": userData.displayName ?? "No name", "name": name ?? "No name", "uid": Auth.auth().currentUser?.uid ?? "No Uid", "url": url ?? "No url", "game": game ?? "No game", "obs": obs ?? "No obs"]) { err in
                if let _err = err {
                    print("deu ruim \(_err)")
                } else {
                    print("deu bom")
                }
            }
            print("\(String(describing: ref?.documentID))")
            ref?.updateData([
                "id": ref?.documentID ?? "No Id"
            ]) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                }
            }

        }
    }
    
    func loadOffers(completion: @escaping (Ofertas?, String?) -> ()) {
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
    
    func loadOffersForIUD(completion: @escaping (Ofertas?, String?) -> ()) {
        self.ofersList.ofertas = []
        db.collection("anuncio").whereField("uid", isEqualTo: Auth.auth().currentUser?.uid ?? "").getDocuments { (query, err) in
            if let e = err {
                print("Deu ruim \(e)")
            } else {
                print("\(self.ofersList)")
                if let document = query?.documents {
                    for doc in document {
                        let data = doc.data()
                        if  let idText = data["id"] as? String, let userName = data["userName"] as? String, let nameText = data["name"] as? String, let urlText = data["url"] as? String, let gameText = data["game"] as? String, let obsText = data["obs"] as? String {
                            let officialArt = OfficialArtwork(imagePath: urlText)
                            let other = Other(dreamWorld: nil, officialArtwork: officialArt)
                            let sprites = Sprites(other: other)
                            let pokeData = PokeData(id: nil, name: nameText, sprites: sprites, stats: nil)
                            let pokemon = Pokemon(sprt: urlText, data: pokeData)
                            let newOfer = OfertaElement(id: idText, game: gameText, pokemon: pokemon, observacoes: obsText, ofertaID: nil, nome: userName, email: Auth.auth().currentUser?.email, telefone: Auth.auth().currentUser?.phoneNumber)
                            self.ofersList.ofertas?.append(newOfer)
                        }
                    }
                }
                completion(self.ofersList, nil)
                print("Deu bom: \(String(describing: query))")
            }
        }
    }
}
