//
//  OfertasWorker.swift
//  Poketrader
//
//  Created by Paulo Vieira on 11/12/20.
//

import Foundation
import Firebase
import FirebaseFirestore
import SCLAlertView

class OfertasWorker: GenericWorker {
    var ofersList = Ofertas()
    let db = Firestore.firestore()
    var phoneNumber: String = ""
    
    func deleteOffer(id: String) {
        db.collection("anuncio").document(id).delete() { err in
            if let err = err {
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("OK") {}
                alertView.showError("Alerta", subTitle: err.localizedDescription)
            } else {
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("OK") {}
                alertView.showSuccess("Com Sucesso", subTitle: "Pokemon foi excluido com sucesso.")
            }
        }
    }
    
    func updateOffer(offer: OfertaElement, nv: String, hp: String, def: String, ata: String, vel: String, ataSp: String, defSp: String, obs: String) {
        let ref = db.collection("anuncio").document(offer.id!)
        ref.updateData([
            "nv": nv,
            "hp": hp,
            "def": def,
            "ata": ata,
            "vel": vel,
            "ataSp": ataSp,
            "defSp": defSp,
            "obs": obs
        ]) { err in
            if let err = err {
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("OK") {}
                alertView.showError("Alerta", subTitle: err.localizedDescription)
            } else {
                let appearance = SCLAlertView.SCLAppearance(
                    showCloseButton: false
                )
                let alertView = SCLAlertView(appearance: appearance)
                alertView.addButton("OK") {}
                alertView.showSuccess("Com Sucesso", subTitle: "Atualização feita com sucesso.")
                print("Document successfully updated")
            }
        }
    }
    
    func saveOffer(name: String?, telefone: String?, url: String?, game: String?, nv: String?, hp: String?, def: String?, ata: String?, vel: String?, defSp: String?, ataSp: String?, obs: String?) {
        
        if let userData = Auth.auth().currentUser {
            let db = Firestore.firestore()
            var ref: DocumentReference? = nil
            ref = db.collection("anuncio").addDocument(data: ["id": ref?.documentID ?? "No Id","telefone": telefone ?? "" , "email": Auth.auth().currentUser?.email ?? "No email", "userName": userData.displayName ?? "No name", "name": name ?? "No name", "uid": Auth.auth().currentUser?.uid ?? "No Uid", "url": url ?? "No url", "game": game ?? "No game", "nv": nv ?? "No nv", "hp": hp ?? "No hp", "def": def ?? "No def", "ata": ata ?? "No ata", "vel": vel ?? "No vel", "defSp": defSp ?? "No def sp", "ataSp": ataSp ?? "No ata sp", "obs": obs ?? "No obs"]) { err in
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
                        if  let telefoneText = data["telefone"] as? String, let userName = data["userName"] as? String,
                            let emailText = data["email"] as? String, let nameText = data["name"] as? String,
                            let urlText = data["url"] as? String, let gameText = data["game"] as? String,
                            let nvText = data["nv"] as? String, let hpText = data["hp"] as? String,
                            let ataText = data["ata"] as? String, let defText = data["def"] as? String,
                            let velText = data["vel"] as? String, let ataSpText = data["ataSp"] as? String,
                            let defSpText = data["defSp"] as? String, let obsText = data["obs"] as? String {
                            let officialArt = OfficialArtwork(imagePath: urlText)
                            let other = Other(dreamWorld: nil, officialArtwork: officialArt)
                            let sprites = Sprites(other: other)
                            let pokeData = PokeData(id: nil, name: nameText, sprites: sprites, stats: nil)
                            let pokemon = Pokemon(sprt: urlText, data: pokeData)
                            let newOfer = OfertaElement(nv: nvText, hp: hpText, def: defText, ata: ataText, vel: velText, defSp: defSpText, ataSp: ataSpText, game: gameText, pokemon: pokemon,  observacoes: obsText, ofertaID: nil, nome: userName, email: emailText, telefone: telefoneText)
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
                        if  let idText = data["id"] as? String, let userName = data["userName"] as? String,
                            let nameText = data["name"] as? String, let urlText = data["url"] as? String, let gameText = data["game"] as? String,
                            let nvText = data["nv"] as? String, let hpText = data["hp"] as? String,
                            let ataText = data["ata"] as? String, let defText = data["def"] as? String,
                            let velText = data["vel"] as? String, let ataSpText = data["ataSp"] as? String,
                            let defSpText = data["defSp"] as? String, let obsText = data["obs"] as? String {
                            let officialArt = OfficialArtwork(imagePath: urlText)
                            let other = Other(dreamWorld: nil, officialArtwork: officialArt)
                            let sprites = Sprites(other: other)
                            let pokeData = PokeData(id: nil, name: nameText, sprites: sprites, stats: nil)
                            let pokemon = Pokemon(sprt: urlText, data: pokeData)
                            let newOfer = OfertaElement(id: idText, nv: nvText, hp: hpText, def: defText, ata: ataText, vel: velText, defSp: defSpText, ataSp: ataSpText, game: gameText, pokemon: pokemon, observacoes: obsText, ofertaID: nil, nome: userName, email: Auth.auth().currentUser?.email, telefone: Auth.auth().currentUser?.phoneNumber)
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
