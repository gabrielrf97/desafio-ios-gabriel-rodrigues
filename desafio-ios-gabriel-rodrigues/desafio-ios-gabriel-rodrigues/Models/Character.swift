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


//class Characters: Decodable {
//    let characters: [Character]
//
//    required init(from coder: Decoder) throws {
//        let container = try coder.container(keyedBy: CodingKeys.self)
//        let outterContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .outterContainer)
//        characters = try outterContainer.decode([Character].self, forKey: .innerContainer)
//    }
//
//    private enum CodingKeys: String, CodingKey {
//        case outterContainer = "data"
//        case innerContainer = "results"
//
//    }
//}

class Character: Decodable {
    let id: Int
//    let name: String
//    let description: String?
//    let pictureUrl: String?
//    let mostExpensiveComic: Comic?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
//        description = try container.decode(String.self, forKey: .description)
//        let pictureContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .picturePath)
//        let picExtension = try pictureContainer.decode(String.self, forKey: .pictureExtension)
//        let picPath = try pictureContainer.decode(String.self, forKey: .picturePath)
//        pictureUrl = "\(picExtension).\(picPath)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
//        case name = "name"
//        case description = "description"
//        case picturePath = "thumbnail"
//        case pictureExtension = "extension"
//        case pictureUrl = "path"
//        case outterContainer = "data"
//        case innerContainer = "results"
    }
}
