//
//  Configuration.swift
//  Poketrader
//
//  Created by André Lucas on 28/01/21.
//

import UIKit

class Configuration {

    static func value<T>(defaultValue: T, forKey key: String) -> T{

        let preferences = UserDefaults.standard
        return preferences.object(forKey: key) == nil ? defaultValue : preferences.object(forKey: key) as! T
    }

    static func value(value: Any, forKey key: String){

        UserDefaults.standard.set(value, forKey: key)
    }

}
