//
//  LoginController.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 30/11/20.
//

import Foundation

class LoginController {
    
    private var email: String?
    private var senha: String?
    
    private var worker: LoginWork?
    
    private var user: User?
    
    init(email: String?, senha: String?) {
        self.email = email
        self.senha = senha
    }
    
    func login(completionHandler: @escaping (_ result: Bool, _ error: String? ) -> Void) {

        LoginWork().loadUsuario(email: self.email ?? "") { (user, error) in
            if let _user = user {
                if user?.senha == self.senha && user?.email == self.email {
                    self.user = _user
                    completionHandler(true, nil)
                } else {
                    completionHandler(false, error)
                }
            } else {
                completionHandler(false, error)
            }
        }
    }
}

