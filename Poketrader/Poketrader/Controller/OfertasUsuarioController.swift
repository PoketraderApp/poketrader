//
//  OfertasUsuarioController.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 06/02/21.
//

import Foundation

class OfertasUsuarioController {
    
    private var ofertas: Ofertas?
    
    func loadOfertas(completion: @escaping (Bool, String?) -> ()) {
        OfertasWorker().loadAnunciosPorIUD { (ofertas, erro) in
            if erro == nil {
                self.ofertas = ofertas
                completion(true, "")
            } else {
                completion(false, "deu ruim")
            }
            
        }
    }
    
    func getOferta(at posicao: Int) -> OfertaElement? {
        return ofertas?.ofertas?[posicao]
    }
    
    var numberOfRows: Int {
        return self.ofertas?.ofertas?.count ?? 0
    }
}
