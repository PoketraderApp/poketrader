//
//  LoginService.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 30/11/20.
//

import Foundation

class LoginWork: GenericWorker {
    
    private var logou: Bool = false
    
    func loadUsuario(email: String, completion: @escaping completion<User?>) {
        let session: URLSession = URLSession.shared
        let url: URL? = URL(string: "https://poketrader-c8754-default-rtdb.firebaseio.com/userList.json")
        
        if let _url = url {
            let task: URLSessionTask = session.dataTask(with: _url) { (data, response, error) in
                do {
                    let userList: Dictionary<String, User> = try JSONDecoder().decode(Dictionary<String, User>.self, from: data ?? Data())

                    print(userList)
                    
                    for (name, value) in userList {
                        if (value.email == email) {
                            self.logou = true
                            let user: User? = value
                            completion(user, nil)
                        }
                    }
                } catch {
                    completion(nil, "Entrou no catch")
                    print(error)
                }
                
                if self.logou == false{
                    completion(nil, "Entrou no catch")
                }
            }
            task.resume()
        }
    }
}
