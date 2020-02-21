//
//  ComicViewModel.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

extension UpdateViewProtocol {
    func updateView(with comicInfo: Comic) {}
}

class ComicViewModel {
    
    weak var viewDelegate: UpdateViewProtocol?
    let server: ClientServer
    var id: Int!
    
    init(server: ClientServer = AppClientServer()) {
        self.server = server
    }
    
    func fetchComic(with id: Int) {
        server.requestComic(with: id, completion: { response in
            switch response {
            case .success(let model):
                if let comics = model {
                    self.viewDelegate?.updateView(with: comics.data.results.first!)
                }
            case .failure(let error):
                self.viewDelegate?.show(error: error)
            }
        })
    }
    
}
