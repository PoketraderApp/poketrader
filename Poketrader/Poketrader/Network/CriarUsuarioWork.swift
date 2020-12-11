//
//  CriarUsuarioWork.swift
//  Poketrader
//
//  Created by André Lucas on 09/12/20.
//

import Foundation
import Alamofire

class CriarUsuarioWork: GenericWorker {
    
    func criarUsuario(usuario: User, completion: @escaping (_ resposta: Bool) -> ()) {
        //        let session: URLSession = URLSession.shared
        let urlString: String =  "https://poketrader-c8754-default-rtdb.firebaseio.com/userList.json"
        let jsonData = try! JSONSerialization.data(withJSONObject: usuario.dictionary, options: .prettyPrinted)
        
        let url = URL(string: urlString)
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = jsonData
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        //        let encoder = JSONEncoder()
        //        encoder.outputFormatting = .prettyPrinted
        //        let dataUser = try! encoder.encode(usuario)
        AF.request(urlRequest).responseString
        { (response) in
            if response.response?.statusCode == 200 {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
