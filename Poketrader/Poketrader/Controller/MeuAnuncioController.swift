//
//  MeuAnuncioController.swift
//  Poketrader
//
//  Created by Paulo Vieira on 12/11/20.
//

import Foundation

class MeuAnuncioController {
    private var ofertas: Ofertas?
    private var worker: MeuAnuncioWorker? // Usando worker para o JSON
    private var ofertaID: String?
    
    // Erro, por algum motivo solicita o mutating
    // Necessário ajustar o ID da oferta. Hoje é possível apontar para o
    //  número do Pokémon, mas e se a pessoa tiver outros? Exemplo: 3 Dragonites.
    func loadOfertaElement(completion: @escaping (_ result: Bool, _ error: String?) -> Void) {
        // Usando worker
        self.worker?.getOfertaMock(ofertaID: self.ofertaID ?? "") { (ofertas, error) in
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

// MARK: - Mover para arquivo separado
class MeuAnuncioWorker {
    typealias completion<T> = (_ result: T, _ failure: String?) -> Void
    
    func getOfertaMock(ofertaID: String, completion: @escaping completion<Ofertas?>) {
        if let path = Bundle.main.path(forResource: "meus-pkmn", ofType: "json") {
            do {
                let ofertas = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let ofertasList = try JSONDecoder().decode(Ofertas.self, from: ofertas)
                let lista = ofertasList.ofertas?.filter({$0.ofertaID == ofertaID})
                
                // MARK: - Avaliar
                // Ajustar tipo
                // Sem o Ofertas(ofertas: lista) acaba-se criando um [OfertaElement]
                // -> Verificar lógica
                let ofertas = Ofertas(ofertas: lista)
                completion(ofertas, nil)
            } catch {
                completion(nil, "Don't fail me again")
            }
        }
    }
    
}
