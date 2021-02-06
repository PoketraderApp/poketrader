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

class User: Codable {
    
    static let userInstance = User()
    
    var nome: String?
    var telefone: String?
    var console: String?
    var email: String?
    var senha: String?
    var dictionary: [String: Any?] {
        return ["nome": nome,
                "telefone": telefone,
                "email": email,
                "senha": senha
        ]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    var sharedUserObject = userObject()
    
    func requestForUser() -> userObject {
        return self.sharedUserObject
    }
    
}

class userObject: Codable {
    var nome: String?
    var telefone: String?
    var console: String?
    var email: String?
    var senha: String?
}
