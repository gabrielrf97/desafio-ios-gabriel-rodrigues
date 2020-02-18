//
//  Router.swift
//  ODMiOS
//
//  Created by Gabriel on 26/02/19.
//  Copyright © 2019 gabrielrodrigues. All rights reserved.
//

import Foundation
import Alamofire

enum Router {
    
    case characters
    case character
    case comic
    
    static var domain = "https://gateway.marvel.com"
    
    static var version = "/v1"
    
    static let pubkey = "92054aba8005e42d62aed24eee96198b"
    private var pvtkey : String {
        return "ae2000662c4b8c79870452c542c63dd907bb81a7"
    }
    static let ts = "sometimestamp"
    
    static var emptyUrl: String {
        return "\(Router.domain)\(Router.version)"
    }
    
    var url: String {
        return "\(Router.domain)\(Router.version)\(self.path)"
    }
    
    var path: String {
        switch self {
        case .characters: return "/public/characters"
        case .character: return "/public/characters"
        case .comic: return "/public/comics"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .characters: return .get
            case .character: return .get
            case .comic: return .get
        }
    }
    
    func stringToHash() -> String {
        return "\(Router.ts+self.pvtkey+Router.pubkey)"
    }
}



