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

class Comic: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let pictureUrl: String?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        id = try container.decode(Int.self, forKey: .id)
        description = try container.decode(String.self, forKey: .description)
        let pictureContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .pictureGroup)
        let picExtension = try pictureContainer.decode(String.self, forKey: .pictureExtension)
        let picPath = try pictureContainer.decode(String.self, forKey: .pictureUrl)
        pictureUrl = "\(picExtension).\(picPath)"
    }
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "description"
        case pictureGroup = "thumbnail"
        case pictureExtension = "extension"
        case pictureUrl = "path"
    }
}
