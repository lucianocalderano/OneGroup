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
        userView.layer.cornerRadius = userView.frame.height / 2
        passView.layer.cornerRadius = passView.frame.height / 2
        loginBtn.layer.cornerRadius = 5
        
        saveCredBtn.layer.borderColor = UIColor.white.cgColor
        saveCredBtn.layer.borderWidth = 2
        showPassBtn.layer.borderColor = UIColor.white.cgColor
        showPassBtn.layer.borderWidth = 2
        
        let me = User.shared.getUser()
        userText.text = me.user
        passText.text = me.pass
        
        #if DEBUG
        userText.text = "admin@admin.it"
        passText.text = "admin_0n3"
        #endif
        
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
        if (userText.text?.count == 0){
            userText.becomeFirstResponder()
            return
        }
        if (passText.text?.count == 0){
            passText.becomeFirstResponder()
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(httpResponse(_:)),
                                               name: Config.Notification.login, object: nil)
        User.shared.login(user: userText.text!, pass: passText.text!, save: (saveCredBtn.tag > 0))
    }
    
    @objc func httpResponse(_ notification:Notification) {
        NotificationCenter.default.removeObserver(self)
        let valid = notification.object as! Bool
        if (valid) {
            let ctrl = HomeController.Instance()
            navigationController?.show(ctrl, sender: self)
            ctrl.menu = notification.userInfo?.string("menu") ?? ""
        }
        else {
            let title = notification.userInfo?.string("msg") ?? "Errore"
            let msg = notification.userInfo?.string("err") ?? "Errore sconosciuto"
            
            let alert = UIAlertController(title: title as String, message: msg  as String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
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
}
