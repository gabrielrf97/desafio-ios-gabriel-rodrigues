//
//  Character.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 17/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

class CharacterResponse: Decodable {
    let data: Results
}

class Results: Decodable {
    let results: [Character]
}

class Character: Decodable {
    let id: Int
    let name: String
    let description: String?
    let pictureUrl: String?
    let comics: [ComicShort]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        let pictureContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .pictureGroup)
        let picExtension = try pictureContainer.decode(String.self, forKey: .pictureExtension)
        let picPath = try pictureContainer.decode(String.self, forKey: .pictureUrl)
        pictureUrl = "\(picExtension).\(picPath)"
        let comicsContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .outterComics)
        comics = try comicsContainer.decode([ComicShort].self, forKey: .comics)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case pictureGroup = "thumbnail"
        case pictureExtension = "extension"
        case pictureUrl = "path"
        case outterContainer = "data"
        case innerContainer = "results"
        case outterComics = "comics"
        case comics = "items"
    }
}
