//
//  OfertasWorker.swift
//  Poketrader
//
//  Created by Paulo Vieira on 11/12/20.
//

import Foundation


class OfertasWorker: GenericWorker {
    
    
    func loadOfertas(completion: @escaping (Ofertas?, String?) -> ()) {
        if let path = Bundle.main.path(forResource: "ofertas", ofType: "json") {
            do {
                let ofertas = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let ofertasList = try JSONDecoder().decode(Ofertas.self, from: ofertas)
                
                completion(ofertasList, nil)
            } catch {
                completion(nil, "Don't fail me again")
            }
        }
    }
    
    func getOferta(id: Int, completion: @escaping completion<OfertaElement?>) {
        if let path = Bundle.main.path(forResource: "ofertas", ofType: "json") {
            do {
                let ofertas = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let ofertasList = try JSONDecoder().decode(Ofertas.self, from: ofertas)
                let lista = ofertasList.ofertas?.filter({$0.ofertaID == id})
                
                let oferta = lista?.first
                completion(oferta, nil)
            } catch {
                completion(nil, "Don't fail me again")
            }
        }
    }
    
    func getOfertaMock(ofertaID: Int, completion: @escaping completion<Ofertas?>) {
        if let path = Bundle.main.path(forResource: "ofertas", ofType: "json") {
            do {
                let ofertas = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let ofertasList = try JSONDecoder().decode(Ofertas.self, from: ofertas)
                let lista = ofertasList.ofertas?.filter({$0.ofertaID == ofertaID})
                
                // MARK: - Avaliar
                // Ajustar tipo
                // Sem o Ofertas(ofertas: lista) acaba-se criando um [OfertaElement]
                // -> Verificar lógica
                let _ofertas = Ofertas(ofertas: lista)
                completion(_ofertas, nil)
            } catch {
                completion(nil, "Don't fail me again")
            }
        }
    }
    
}
