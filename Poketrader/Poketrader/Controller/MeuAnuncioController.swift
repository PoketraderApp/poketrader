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
    
//    func loadOfertaElement(completion: @escaping (_ result: Bool, _ error: String?) -> Void) {
//        // Usando worker
//        self.worker?.getOfertaMock(ofertaID: self.ofertaID ?? 0) { (ofertas, error) in
//            if let _ofertas = ofertas {
//                print(_ofertas)
//                self.ofertas = _ofertas
//                completion(true, nil)
//            } else {
//                completion(false, "your Controller class ")
//            }
//        }
//    }
    
//    func loadOfertas(completion: @escaping (Bool, String?) -> ()) {
//        OfertasWorker().loadAnunciosPorIUD { (ofertas, erro) in
//            if erro == nil {
//                self.ofertas = ofertas
//                completion(true, "")
//            } else {
//                completion(false, "deu ruim")
//            }
//            
//        }
//    }
    
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

