//
//  GenericWork.swift
//  Poketrader
//
//  Created by Bruno da Fonseca on 09/12/20.
//

import Foundation

enum Method:String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

class GenericWorker {
    
    typealias completion <T> = (_ result: T, _ failure: String?) -> Void
    
}
