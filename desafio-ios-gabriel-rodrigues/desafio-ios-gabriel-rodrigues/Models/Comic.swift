//
//  Comic.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 17/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

struct ComicShort: Decodable {
    var resourceURI: String
}

class ComicRespose: Decodable {
    let data: ComicResults
}

class ComicResults: Decodable {
    let results: [Comic]
}

struct Price: Decodable {
    let type: String
    let price: Float

    func getType() -> String{
        if type.contains("digital") {
            return "Digital"
        } else if type.contains("print") {
            return "Impressa"
        } else {
            return type
        }
    }
}

class Comic: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let pictureUrl: String?
    let prices: [Price]?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decode(Int.self, forKey: .id)
        description = try? container.decode(String.self, forKey: .description) 
        let pictureContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .pictureGroup)
        let picExtension = try pictureContainer.decode(String.self, forKey: .pictureExtension)
        let picPath = try pictureContainer.decode(String.self, forKey: .pictureUrl)
        pictureUrl = "\(picPath).\(picExtension)"
        prices = try container.decode([Price].self, forKey: .prices)
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case pictureGroup = "thumbnail"
        case pictureExtension = "extension"
        case pictureUrl = "path"
        case prices = "prices"
    }
}
