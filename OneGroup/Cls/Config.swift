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
    struct Notification {
        static let login = NSNotification.Name(rawValue: "loginNotification")
    }
}

class MyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black
        let background = UIImage(named: "Sfondo.jpg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class MyBackButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize () {
        self.imageEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
}
