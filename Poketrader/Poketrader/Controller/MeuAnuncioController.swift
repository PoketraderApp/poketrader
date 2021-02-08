//
//  MeuAnuncioController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 12/11/20.
//

import Foundation

class MeuAnuncioController {
    
    private var oferta: OfertaElement?
    private var ofertas: Ofertas?
    private var worker: OfertasWorker? // Usando worker para o JSON
    private var ofertaID: Int?
    
    func removeOffer(id: String) {
        self.worker = OfertasWorker()
        self.worker?.deleteOffer(id: id)
    }
    
    func insereOferta(oferta: OfertaElement) {
        print("Entrou setOferta")
        self.oferta = oferta
    }
    
    func loadAnuncio(completion: @escaping (OfertaElement?, String?) -> ()) {
        if let oferta = self.oferta {
            self.oferta = oferta
            completion(oferta, nil)
        } else {
            print("deu ruim")
            completion(nil,"deu ruim")
        }
    }
    
    func getOfertaID(at posicao: Int) -> Int {
        return ofertas?.ofertas?[posicao].ofertaID ?? 0
    }
    
//    func getOferta(at posicao: Int) -> OfertaElement? {
//        return ofertas?.ofertas?[posicao]
//    }
    
    var numberOfRows: Int {
        return self.ofertas?.ofertas?.count ?? 0
    }
    
    func loadCurrentOffer(indexPath: Int) -> OfertaElement? {
        return self.ofertas?.ofertas?[indexPath]
    }
    
}

