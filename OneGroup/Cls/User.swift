//
//  User.swift
//  OneGroup
//
//  Created by Developer on 01/08/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

class User  {
    static let shared = User()
    var token = ""
    private var user = ""
    private var pass = ""
    
    func getUser () -> (user: String, pass: String) {
        user = UserDefaults.standard.string(forKey: "user") ?? ""
        pass = UserDefaults.standard.string(forKey: "pass") ?? ""
        return (user, pass)
    }
    
    func login (user: String, pass: String, save: Bool) {
        self.user = user
        self.pass = pass
        
        if (save) {
            UserDefaults.standard.set(user, forKey: "user")
            UserDefaults.standard.set(pass, forKey: "pass")
        }
        else {
            UserDefaults.standard.set("", forKey: "user")
            UserDefaults.standard.set("", forKey: "pass")
        }
        login()
    }
    
    func login () {
        let dict: JsonDict = [
            "grant_type"    : "password",
            "client_id"     : "f3d259ddd3ed8ff3843839b",
            "client_secret" : "4c7f6f8fa93d59c45502c0ae8c4a95b",
            "username"      : user,
            "password"      : pass
        ]
        let req = MYHttp.init(.grant, param: dict)
        req.load(ok: {
            (response) in
            let dictToken = response.dictionary("token")
            self.token = dictToken.string("access_token")
            let dictMenus = response.string("menu")
            let dict = [
                "menu" : dictMenus
                ] as JsonDict
            
            NotificationCenter.default.post(name: Config.Notification.login, object: true, userInfo: dict)
        }) {
            (err, msg) in
            let dict = [
                "err" : err,
                "msg" : msg
            ] as JsonDict
            NotificationCenter.default.post(name: Config.Notification.login, object: false, userInfo: dict)
        }
    }
}
