//
//  Usuario.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 30/11/20.
//

import Foundation

struct UserList: Codable {
    var userList: [User]?
}

struct User: Codable {
    
    var email: String
    var nome: String
    var senha: String
    var telefone: Int

}
