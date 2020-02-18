//
//  ServerClient.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

protocol ClientServer {
    func requestCharacters(name: String?, completion: @escaping (NetworkLayerResult<[Character]>) -> Void)
    func requestCharacter(with id: Int, completion: @escaping (NetworkLayerResult<Character>) -> Void)
    func requestComic(with id: Int, completion: @escaping (NetworkLayerResult<Comic>) -> Void)
}

struct AppClientServer: ClientServer {

    func requestCharacters(name: String?, completion: @escaping (NetworkLayerResult<[Character]>) -> Void) {
        
    }
    
    func requestCharacter(with id: Int, completion: @escaping (NetworkLayerResult<Character>) -> Void) {
        
    }
    
    func requestComic(with id: Int, completion: @escaping (NetworkLayerResult<Comic>) -> Void) {
        
    }
}

struct MockClientServer: ClientServer {
    func requestCharacters(name: String?, completion: @escaping (NetworkLayerResult<[Character]>) -> Void) {
        
    }
    
    func requestCharacter(with id: Int, completion: @escaping (NetworkLayerResult<Character>) -> Void) {
        
    }
    
    func requestComic(with id: Int, completion: @escaping (NetworkLayerResult<Comic>) -> Void) {
        
    }
}
