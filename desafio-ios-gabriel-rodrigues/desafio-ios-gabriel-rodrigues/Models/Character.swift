//
//  Character.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 17/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String
    let description: String?
    let pictureUrl: String?
    let mostExpensiveComic: Comic?
}
