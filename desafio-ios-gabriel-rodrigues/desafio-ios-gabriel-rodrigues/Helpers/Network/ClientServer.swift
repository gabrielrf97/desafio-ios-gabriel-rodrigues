//
//  ServerClient.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

protocol ClientServer {
    func requestCharacters(name: String?, completion: @escaping (NetworkResult<CharacterResponse>) -> Void)
    func requestCharacter(with id: Int, completion: @escaping (NetworkResult<Character>) -> Void)
    func requestComic(with id: Int, completion: @escaping (NetworkResult<Comic>) -> Void)
}

struct AppClientServer: ClientServer {

    func requestCharacters(name: String?, completion: @escaping (NetworkResult<CharacterResponse>) -> Void) {
        
        var params = Parameters()
        
//        if let _name = name {
//            params["name"] = _name
//        }
        Network.shared.request(.characters, parameters: &params, model: CharacterResponse.self, completion: { response in
            switch response {
            case .success(let model):
                completion(.success(model: model))
            case .failure(let error):
                completion(.failure(error: error))
            }
        })
    }
    
    func requestCharacter(with id: Int, completion: @escaping (NetworkResult<Character>) -> Void) {
    
        var params : Parameters = ["characterId":id]
        
        Network.shared.request(.characters, parameters: &params, model: Character.self, completion: { response in
            switch response {
            case .success(let model):
                completion(.success(model: model))
            case .failure(let error):
                completion(.failure(error: error))
            }
        })
    }
    
    func requestComic(with id: Int, completion: @escaping (NetworkResult<Comic>) -> Void) {
        
        var params : Parameters = ["comicId":id]
        
        Network.shared.request(.characters, parameters: &params, model: Comic.self, completion: { response in
            switch response {
            case .success(let model):
                completion(.success(model: model))
            case .failure(let error):
                completion(.failure(error: error))
            }
        })
    }
}

struct MockClientServer: ClientServer {
    func requestCharacters(name: String?, completion: @escaping (NetworkResult<CharacterResponse>) -> Void) {
        
    }
    
    func requestCharacter(with id: Int, completion: @escaping (NetworkResult<Character>) -> Void) {
        
    }
    
    func requestComic(with id: Int, completion: @escaping (NetworkResult<Comic>) -> Void) {
        
    }
}
