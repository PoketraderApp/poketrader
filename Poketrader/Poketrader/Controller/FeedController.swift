//
//  FeedController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 11/12/20.
//

import Foundation

class FeedController {
    //TODO:- private var worker: OfertasWork()
    private var ofertas: Ofertas?
    
    var numberOfRows: Int {
        return ofertas?.ofertas?.count ?? 0
    }
    
    func getOfertaID(at posicao: Int) -> Int {
        return ofertas?.ofertas?[posicao].ofertaID ?? 0
    }
    
    func getOferta(at posicao: Int) -> OfertaElement? {
        return ofertas?.ofertas?[posicao]
    }
    
    func loadOfertas(completion: @escaping (Bool, String?) -> ()) {
        OfertasWorker().loadOfertas() { (ofertas, erro) in
            if erro == nil {
                self.ofertas = ofertas
                completion(true, "")
            } else {
                completion(false, "deu ruim")
            }
            
        }
    }
    
}
