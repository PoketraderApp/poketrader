//
//  PerfilController.swift
//  Poketrader
//
//  Created by André Lucas on 30/01/21.
//

import Foundation

class PerfilController {
    weak var delegate: perfilViewControllerDelegate?
    
    func formattedNumber(number: String) -> String {
        
        let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(##) ##### ####"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        for ch in mask where index < cleanPhoneNumber.endIndex {
            
            if ch == "#" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
                
            } else {
                result.append(ch)
            }
        }
        return result
    }
    
    func atualizarUsuario(nome: String, telefone: String, email: String, console: String, imagem: Data?, completion: @escaping (Error?) -> Void) {
        AuthenticationWorker().upload(nome: nome, telefone: telefone, email: email, console: console, imagem: imagem, completion: completion)

        
//        worker?.criarUsuario(completion: { (resposta) in
//            self.delegate?.usuarioCriado(result: resposta)
//        })
    }
}
