//
//  SingleCharacterViewModel.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

class SingleCharacterViewModel {
    
    var character : Character!
    let server : ClientServer
    
    init(server: ClientServer = AppClientServer()) {
        self.server = server
    }
    
    func fetchCharacter(with id: Int) {
        server.requestCharacter(with: id, completion: { response in
            switch response {
            case .success(let model):
                break
            case .failure(let error):
                break
            }
        })
    }
}
