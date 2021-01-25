//
//  LoginController.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 30/11/20.
//

import Foundation

class LoginController {
    
    // private var worker: AuthenticationWorker?
    
    
    func login(email: String, senha: String, completion: @escaping (Error?) -> Void) {
        AuthenticationWorker().login(email: email, senha: senha, completion: completion)
        
//        AuthenticationWorker().loadUsuario(email: self.email ?? "") { (user, error) in
//            if let _user = user {
//                if user?.senha == self.senha && user?.email == self.email {
//                    self.user = _user
//                    completionHandler(true, nil)
//                } else {
//                    completionHandler(false, error)
//                }
//            } else {
//                completionHandler(false, error)
//            }
//        }
    }
    
    func forgotPassword(email: String, completion: @escaping (Error?) -> Void) {
        AuthenticationWorker().forgotPassword(email: email, completion: completion)
    }
}

