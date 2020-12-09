//
//  LoginService.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 30/11/20.
//

import Foundation

class LoginWork: GenericWorker {
    
    func loadUsuario(email: String, completion: @escaping completion<User?>) {
        let session: URLSession = URLSession.shared
        let url: URL? = URL(string: "https://poketrader-c8754-default-rtdb.firebaseio.com/.json")
        
        if let _url = url {
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
                do {
                    let userList = try JSONDecoder().decode(UserList.self, from: data ?? Data())
                    if let _userList = userList.userList {
                        let user = _userList.first
                        completion(user, nil)
                    } else {
                        completion(nil, "Não fez o parse")
                        print("nao fez parse")
                    }
                } catch {
                    completion(nil, "Entrou no catch")
                    print(error)
                }
            }
            task.resume()
        }
    }
}
