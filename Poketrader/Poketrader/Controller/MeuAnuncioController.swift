//
//  MeuAnuncioController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 12/11/20.
//

import Foundation

struct MeuAnuncioController {
    private var ofertaElement: OfertaElement?
    private var ofertaID: String?
    private var worker: MeuAnuncioWorker? // Usando worker para o JSON
    
    
    // Erro, por algum motivo solicita o mutating
    // Necessário ajustar o ID da oferta. Hoje é possível apontar para o
    //  número do Pokémon, mas e se a pessoa tiver outros? Exemplo: 3 Dragonites.
    mutating func loadOfertaElement(completion: @escaping (_ result: Bool, _ error: String?) -> Void) {
        // Usando worker
        self.worker?.getOfertaMock(ofertaID: self.ofertaID ?? "") { (ofertaElement, error) in
            if var _ofertaElement = ofertaElement {
                print(_ofertaElement)
                print("Deu bom")
                // MARK: - erro abaixo -
                self.ofertaElement = OfertaElement()
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}

// MARK: - Mover para arquivo separado
class MeuAnuncioWorker {
    typealias completion<T> = (_ result: T, _ failure: String?) -> Void
    
    func getOfertaMock(ofertaID: String, completion: @escaping completion<OfertaElement?>) {
        
        if var path = Bundle.main.path(forResource: "meus-pkmn", ofType: "json") {
            do {
                var ofertas = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                var ofertasList = try JSONDecoder().decode(Ofertas.self, from: ofertas)
                print(">>>> Minhas Ofertas List")
                print(ofertasList)
//                let lista = ofertasList.filter({?0.id == ofertaID}) // ?
                var ofertaListaElement = lista?.first
                completion(ofertaListaElement, nil)
            } catch {
                print(">>>> Your offer has failed")
                completion(nil, "Don't fail me again")
            }
        }
    }
}
