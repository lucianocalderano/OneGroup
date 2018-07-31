//
//  Config.swift
//  MysteryClient
//
//  Created by mac on 26/06/17.
//  Copyright © 2017 Mebius. All rights reserved.
//
// git: mcappios@git.mebius.it:projects/mcappios - Pw: Mc4ppIos
// web: mysteryclient.mebius.it - User: utente_gen - Pw: novella44

import Foundation
import LcLib

typealias JsonDict = Dictionary<String, Any>
func Lng(_ key: String) -> String {
    return MYLang.value(key)
}

struct Config {
    struct Url {
        static let home  = "http://onegroup.mebius.it/"
        static let grant = Config.Url.home + "oauth/access_token"
        static let get   = Config.Url.home + "default/rest/get"
        static let post  = Config.Url.home + "default/rest/post"
    }
    struct Auth {
        static let header = "Auth "
        static var token = ""
    }
}
