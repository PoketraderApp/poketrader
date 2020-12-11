//
//  MeuAnuncioController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 12/11/20.
//

import Foundation

class MeuAnuncioController {
    private var ofertas: Ofertas?
    private var worker: OfertasWorker? // Usando worker para o JSON
    private var ofertaID: Int?
    func loadOfertaElement(completion: @escaping (_ result: Bool, _ error: String?) -> Void) {
        // Usando worker
        self.worker?.getOfertaMock(ofertaID: self.ofertaID ?? 0) { (ofertas, error) in
            if let _ofertas = ofertas {
                print(_ofertas)
                self.ofertas = _ofertas
                completion(true, nil)
            } else {
                completion(false, "your Controller class ")
            }
        }
    }
    
    var numberOfRows: Int {
        return self.ofertas?.ofertas?.count ?? 0
    }
    
    func loadCurrentOffer(indexPath: Int) -> OfertaElement? {
        return self.ofertas?.ofertas?[indexPath]
    }
}

