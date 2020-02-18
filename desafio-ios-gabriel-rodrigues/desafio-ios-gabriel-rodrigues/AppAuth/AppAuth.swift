//
//  AppAuth.swift
//  ioasys-challenge
//
//  Created by Gabriel on 15/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import Foundation

enum AuthKeys: String {
    case email = "email"
    case password = "password"
    case id = "id"
    case name = "name"
    case token = "token"
    case client = "client"
    case auth = "auth"
}

class AuthModel: NSObject, NSCoding{
    
    var password: String
    var client: String
    var token: String
    var email: String
    var uid: String {
        return self.email
    }
    
    init(email: String, password: String, client: String, token: String) {
        self.email = email
        self.password = password
        self.client = client
        self.token = token
    }
    
    required convenience init?(coder: NSCoder) {
        let email = coder.decodeObject(forKey: AuthKeys.email.rawValue) as! String
        let password = coder.decodeObject(forKey: AuthKeys.password.rawValue) as! String
        let token = coder.decodeObject(forKey: AuthKeys.token.rawValue) as! String
        let client = coder.decodeObject(forKey: AuthKeys.client.rawValue) as! String
        
        self.init(email: email, password: password, client: client, token: token)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(email, forKey: AuthKeys.email.rawValue)
        coder.encode(password, forKey: AuthKeys.password.rawValue)
        coder.encode(client, forKey: AuthKeys.client.rawValue)
        coder.encode(token, forKey: AuthKeys.token.rawValue)
    }
    
}

class AppAuth {
    
    var auth : AuthModel?
    
    static let shared = AppAuth()
    
    init() {
        loadAuth()
    }
    
    func loadAuth() {

        if let decodedAuth = UserDefaults.standard.object(forKey: AuthKeys.auth.rawValue) as? Data {
            do {
                let auth = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [AuthModel.self], from: decodedAuth) as! AuthModel
                self.auth = auth
            } catch {
                return
            }
        }
    }
    
    func update(email: String, password: String, client: String, token: String) {
        self.signin(email: email, password: password, client: client, token: token)
    }
    
    func signin(email: String, password: String, client: String, token: String) {
        let auth = AuthModel(email: email, password: password, client: client, token: token)
        self.auth = auth
        let archievedAuth = try? NSKeyedArchiver.archivedData(withRootObject: auth, requiringSecureCoding: false)
        UserDefaults.standard.setValue(archievedAuth, forKey: AuthKeys.auth.rawValue)
    }
    
    func logout() {
        self.auth = nil
        UserDefaults.standard.removeObject(forKey: AuthKeys.auth.rawValue)
    }
}
