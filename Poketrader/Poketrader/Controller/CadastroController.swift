//
//  CadastroController.swift
//  Poketrader
//
//  Created by Gabriel Duarte on 12/11/20.
//

import Foundation

class CadastroController {
    
    private var worker: CriarUsuarioWork? = CriarUsuarioWork()
    weak var delegate: cadastroViewControllerDelegate?
    
//    init() {
//
////        worker = CriarUsuarioWork()
//    }
    
    func isValidEmail(_ email: String) -> Bool{
        
        let emailRegEx = "\\b([a-z 0-9]+)((\\.|_)?([a-z 0-9]+))+@([a-z]+)(\\.([a-z]{2,}))+\\b"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        
        return emailTest.evaluate(with: email)
    }
    
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
    
    func cadastrarUsuario(nome: String, telefone: Int, email: String, senha: String) {
        var usuario : User = User()
        usuario.nome = nome
        usuario.telefone = telefone
        usuario.senha = senha
        usuario.email = email
        worker?.criarUsuario(usuario: usuario, completion: { (resposta) in
            self.delegate?.usuarioCriado(result: resposta)
        })
    }
    
    
}
