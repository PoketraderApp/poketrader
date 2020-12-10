//
//  PokeData.swift
//  Poketrader
//
//  Created by Paulo Vieira on 05/12/20.
//

import Foundation

struct PokeData: Codable {
    let id: Int?
    let name: String?
    let sprite: Sprites?
    let stats: [StatElement]?
}

struct Sprites: Codable {
    let other: Other?
}

struct Other: Codable {
    let dreamWorld: DreamWorld?
    let officialArtwork: OfficialArtwork?
    
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case officialArtwork = "official-artwork"
    }
}

struct DreamWorld: Codable {
    let imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case imagePath = "front_default"
    }
}

struct OfficialArtwork: Codable {
    let imagePath: String?
    
    enum CodingKeys: String, CodingKey {
        case imagePath = "front_default"
    }
}

struct StatElement: Codable {
    let baseValue: Int?
    let statInfo: StatInfo?
    
    enum CodingKeys: String, CodingKey {
        case baseValue = "base_stat"
        case statInfo = "stat"
    }
}

struct StatInfo: Codable {
    let name: String?
}
