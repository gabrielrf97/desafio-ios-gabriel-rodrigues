//
//  Network.swift
//  ODMiOS
//
//  Created by Gabriel on 26/02/19.
//  Copyright © 2019 gabrielrodrigues. All rights reserved.
//

import Foundation
import Alamofire
import CommonCrypto

typealias Parameters = [String : Any]

enum NetworkLayerResult<Model> {
    case success (model: Model?)
    case failure (error: String)
}

enum NetworkResult<Model> {
    case success (model: Model?, client: String, token: String)
    case failure (error: String)
}

class Network {
    
    static let shared = Network()
    
    private init() {}
    
    func request<Model:Decodable>(_ router: Router, parameters: inout Parameters?, model: Model.Type, completion: @escaping (NetworkResult<Model>) -> Void) {
        
        URLCache.shared.removeAllCachedResponses()
        
        appendAuthParameters(&parameters!)
        
        Alamofire.request(router.url, method: router.method , parameters: parameters)
            .validate()
            .response { response in
                
            do {
                
                var object: Model?
                var client: String!
                var token: String!
                
                if let error = response.error as NSError? {
                    
                    switch error.code {
                    case -1009:
                        completion(.failure(error: "No internet connection"))
                    case -1004:
                        completion(.failure(error: "We could not connect to the server"))
                    default:
                        completion(.failure(error: "\(String(data: response.data!, encoding: .utf8))"))
                    }
                    
                    return
                }
                
                if response.data?.count != 0 {
                    object = try JSONDecoder().decode(model, from: response.data!)
                    if let headers = response.response?.allHeaderFields {
                        client = headers["client"] as? String
                        token = headers["access-token"] as? String
                    }
                }
                
                completion(.success(model: object, client: client, token: token))
                
            } catch {
                completion(.failure(error: "Sorry, something went wrong"))
            }
        }
    }
    
    func appendAuthParameters(_ parameters: inout Parameters) {
        parameters["apikey"] = "92054aba8005e42d62aed24eee96198b"
        parameters["ts"] = "somerandomstring"
        parameters["hash"] = MD5(Router.stringToHash(.login)())
    }
    
    func MD5(_ string: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)

        if let d = string.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes { (body: UnsafePointer<UInt8>) in
                CC_MD5(body, CC_LONG(d.count), &digest)
            }
        }

        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}