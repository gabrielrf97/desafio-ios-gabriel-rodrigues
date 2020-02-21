//
//  SingleCharacterViewModel.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

struct ComicInfo {
    let id: Int
    let pictureUrl: String
}

protocol SigleCharacterViewDelegate: class {
    func updateView()
    func show(error: String)
}

class SingleCharacterViewModel {
    
    var character : Character!
    let server : ClientServer
    var comics: [Comic]?
    weak var delegate: SigleCharacterViewDelegate?
    
    init(server: ClientServer = AppClientServer()) {
        self.server = server
    }

    func fetch(_ comics: [ComicShort]) {
        self.comics = [Comic]()
        DispatchQueue.global(qos: .userInitiated).async {
            for comic in comics {
                let id = self.getComicId(inUri: comic.resourceURI)
                self.server.requestComic(with: id, completion: { response in
                    switch response {
                    case .success(let response):
                        self.comics?.append((response?.data.results.first!)!)
                    case .failure(let error):
                        self.delegate?.show(error: error)
                    }
                    if comics.count == self.comics?.count {
                        self.delegate?.updateView()
                    }
                })
            }
        }
    }
    
    
    
//    private func 
    
    private func getComicId(inUri uri: String) -> Int {
        let comicId = String(uri.split(separator: "/").last!)
        return Int(comicId)!
    }
}
