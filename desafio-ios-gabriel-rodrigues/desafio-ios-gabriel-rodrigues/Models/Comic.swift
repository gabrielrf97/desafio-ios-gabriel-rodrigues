//
//  Comic.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 17/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

struct Comic: Decodable {
    let id: Int?
    let title: String?
    let digitalPrice: String?
    let paperPrice: String?
    let description: String?
    let pictureUrl: String?
}
