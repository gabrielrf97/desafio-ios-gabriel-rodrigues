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

protocol UpdateViewProtocol: class {
    func show(error: String)
}

extension UpdateViewProtocol {
    func updateView(with charactersInfo: [CharacterInfo]) {}
}

protocol ViewProtocol: class {
     func show(error: String)
     func updateView(with charactersInfo: [CharacterInfo])
}

class CharactersViewModel {
    
    let server: ClientServer
    weak var delegate: ViewProtocol?
    var characters = [Character]()
    var charactersInfo = [CharacterInfo]()
    
    init(server: ClientServer = AppClientServer()) {
        self.server = server
    }
    
    func fetchCharacters(name: String) {
        server.requestCharacters(name: name, completion: { response in
            switch response {
            case .success(let model):
                if let _characters = model?.data.results {
                    self.setCharacters(characters: _characters)
                    self.castData(characters: _characters)
                    self.delegate?.updateView(with: self.charactersInfo)
                }
            case .failure(let error):
                self.delegate?.show(error: error)
            }
        })
    }
    
    private func castData(characters: [Character]) {
        charactersInfo.removeAll()
        for char in characters {
            let characterInfo = CharacterInfo(name: char.name, pictureUrl: char.pictureUrl, id: char.id)
            charactersInfo.append(characterInfo)
        }
    }
    
    private func setCharacters(characters: [Character]) {
        self.characters.removeAll()
        self.characters = characters
    }
}
