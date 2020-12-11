//
//  Pokemon.swift
//  Poketrader
//
//  Created by Paulo Vieira on 05/12/20.
//

import Foundation

struct Pokemon: Codable {

    let id: Int?
    let name: String?
    let sprite: String? // URL com imagem do pokémon
    var stats: [Stat]?

    init(data: PokeData) {
        id = data.id
        name = data.name
        sprite = data.sprite?.other?.officialArtwork?.imagePath
        stats = []
        if let dataStats = data.stats {
            for stat in dataStats {
                if let statName = stat.statInfo?.name {
                    stats?.append(Stat(name: statName, value: stat.baseValue))
                }
            }
        }
    }
}

struct Stat: Codable {
    let name: String?
    let value: Int?
}
