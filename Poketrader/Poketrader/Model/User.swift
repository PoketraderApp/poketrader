//
//  Usuario.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 30/11/20.
//

import Foundation

struct UserList: Codable {
    var userList: [User]
}

struct User: Codable {
    
    var nome: String?
    var telefone: Int?
    var email: String?
    var senha: String?
    var dictionary: [String: Any] {
            return ["nome": nome,
                    "telefone": telefone,
                    "email": email,
                    "senha": senha
                    ]
        }
        var nsDictionary: NSDictionary {
            return dictionary as NSDictionary
        }
    
}
