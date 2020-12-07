//
//  LoginController.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 30/11/20.
//

import Foundation

class LoginController {
    
    let service: LoginService = LoginService()
    
    func login(email:String?, senha:String?) -> Bool {
        
        let usuario = service.loadUsuario()
        
        if usuario?.email == email {
            if usuario?.senha == senha {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
}
