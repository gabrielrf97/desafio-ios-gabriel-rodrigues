//
//  CharactersViewModel.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

struct CharacterInfo {
    let name: String
    let pictureUrl: String?
    let id: Int
}

protocol CharactersViewProtocol: class {
    func updateView(with charactersInfo: [CharacterInfo])
    func show(error: String)
}

class CharactersViewModel {
    
    let server: ClientServer
    weak var delegate: CharactersViewProtocol?
    var charactersInfo = [CharacterInfo]()
    
    init(server: ClientServer = AppClientServer()) {
        self.server = server
    }
    
    func fetchCharacters(name: String) {
        server.requestCharacters(name: name, completion: { response in
            switch response {
            case .success(let model):
                if let _characters = model {
                    self.castData(characters: _characters)
                    self.delegate?.updateView(with: self.charactersInfo)
                }
            case .failure(let error):
                self.delegate?.show(error: error)
            }
        })
    }
    
    func castData(characters: [Character]) {
        charactersInfo.removeAll()
        for char in characters {
            let characterInfo = CharacterInfo(name: char.name, pictureUrl: char.pictureUrl, id: char.id)
            charactersInfo.append(characterInfo)
        }
    }
}
