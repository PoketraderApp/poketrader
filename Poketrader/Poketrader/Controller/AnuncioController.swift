//
//  AnuncioController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 10/11/20.
//

import Foundation

class AnuncioController {
    // var anuncio: Anuncio?
    private var ofertaID: Int?
    private var oferta: OfertaElement?
    
    var pokemonName: String? {
        return oferta?.pokemon?.name
    }
    
    var nomeUsuario: String? {
        return oferta?.nome
    }
    
    var emailUsuario: String? {
        return oferta?.email
    }
    
    var telefoneUsuario: String? {
        return oferta?.telefone
    }
    
    var imageID: String? {
        return String(oferta?.pokemon?.id ?? 4)
    }
    
    var observacoes: String? {
        return oferta?.observacoes
    }
    
    func setID(id: Int) {
        self.ofertaID = id
        
    }
    
    func loadAnuncio(completion: @escaping (Bool, String?) -> ()) {
        if let ofertaID = ofertaID {
            OfertasWorker().getOferta(id: ofertaID) { (oferta, erro) in
                if erro == nil {
                    self.oferta = oferta
                    completion(true, nil)
                } else {
                    print("deu ruim")
                    completion(false,"deu ruim")
                }
            }
        }
    }
    
    
    
    
    
}
