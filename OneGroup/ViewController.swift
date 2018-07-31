//
//  ViewController.swift
//  OneGroup
//
//  Created by Developer on 31/07/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var userView: UIView!
    @IBOutlet var passView: UIView!
    
    @IBOutlet var userText: UITextField!
    @IBOutlet var passText: UITextField!
    
    @IBOutlet var saveCredBtn: UIButton!
    @IBOutlet var showPassBtn: UIButton!
    @IBOutlet var loginBtn: UIButton!

    let check = UIImage.init(named: "check")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        userText.text = "admin@admin.it"
        passText.text = "admin_0n3"
        #endif

        userView.layer.cornerRadius = userView.frame.height / 2
        passView.layer.cornerRadius = passView.frame.height / 2
        loginBtn.layer.cornerRadius = 5
        
        saveCredBtn.layer.borderColor = UIColor.white.cgColor
        saveCredBtn.layer.borderWidth = 2
        showPassBtn.layer.borderColor = UIColor.white.cgColor
        showPassBtn.layer.borderWidth = 2
        
        userText.text = UserDefaults.standard.string(forKey: "user")
        passText.text = UserDefaults.standard.string(forKey: "pass")
        
        if ((userText.text?.count)! > 0 && (passText.text?.count)! > 0) {
            selectButton(btn: saveCredBtn)
        }
    }
    
    @IBAction func saveSelected () {
        selectButton(btn: saveCredBtn)
    }
    @IBAction func showSelected () {
        selectButton(btn: showPassBtn)
        passText.isSecureTextEntry = showPassBtn.tag == 0
    }

    @IBAction func loginSelected () {
    }
    
    func selectButton(btn: UIButton){
        if (btn.tag > 0) {
            btn.tag = 0
            btn.setBackgroundImage(UIImage(), for: .normal)
        } else {
            btn.tag = 1
            btn.setBackgroundImage(check, for: .normal)
        }
    }
    
    func loeggedIn () {
        if (saveCredBtn.tag > 0) {
            UserDefaults.standard.set(userText.text, forKey: "user")
            UserDefaults.standard.set(passText.text, forKey: "pass")
        }
    }
    
}

/*
 grant_type:password
 client_id:f3d259ddd3ed8ff3843839b
 client_secret:4c7f6f8fa93d59c45502c0ae8c4a95b
 username:admin@admin.it
 password:admin_0n3
 */
