//
//  ServerClient.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

protocol ClientServer {
    func requestCharacters(name: String?, completion: @escaping (NetworkResult<CharacterResponse>) -> Void)
    func requestComic(with id: Int, completion: @escaping (NetworkResult<ComicRespose>) -> Void)
    func getImage(forUrl url: String, completion: @escaping(UIImage) -> ())
}

struct AppClientServer: ClientServer {

    func requestCharacters(name: String?, completion: @escaping (NetworkResult<CharacterResponse>) -> Void) {
        
        var params = Parameters()
        
        if let _name = name {
            if !_name.isEmpty {
                params["nameStartsWith"] = _name
            }
        }
        Network.shared.request(.characters, parameters: &params, model: CharacterResponse.self, completion: { response in
            switch response {
            case .success(let model):
                completion(.success(model: model))
            case .failure(let error):
                completion(.failure(error: error))
            }
        })
    }
    
    func requestComic(with id: Int, completion: @escaping (NetworkResult<ComicRespose>) -> Void) {
        
        Router.currentId = id
        
        var params = Parameters()
        
        Network.shared.request(.comic, parameters: &params, model: ComicRespose.self, completion: { response in
            switch response {
            case .success(let model):
                completion(.success(model: model))
            case .failure(let error):
                completion(.failure(error: error))
            }
        })
    }
    
    func getImage(forUrl url: String, completion: @escaping(UIImage) -> ()){
        Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else {
                return
            }
            completion(image)
        }
    }
}

struct MockClientServer: ClientServer {
    func requestCharacters(name: String?, completion: @escaping (NetworkResult<CharacterResponse>) -> Void) {
        
    }
    
    func requestCharacter(with id: Int, completion: @escaping (NetworkResult<Character>) -> Void) {
        
    }
    
    func requestComic(with id: Int, completion: @escaping (NetworkResult<ComicRespose>) -> Void) {
        
    }
    
    func getImage(forUrl url: String, completion: @escaping(UIImage) -> ()) {
        
    }
}
