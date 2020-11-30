//
//  LoginService.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 30/11/20.
//

import Foundation

class LoginService {
    
    func loadUsuario() -> Usuario? {
        
        if let path = Bundle.main.path(forResource: "usuario", ofType: "json"){
        
            do {
                
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let usuario = try JSONDecoder().decode(Usuario.self, from: data)
                
                return usuario
               
            }catch{
                print("Deu ruim no parse")
                return nil
            }

        
        }
        return nil
    }
    
}
