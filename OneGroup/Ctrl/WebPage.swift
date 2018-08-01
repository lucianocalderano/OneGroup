//
//  WebPage
//  MysteryClient
//
//  Created by mac on 26/06/17.
//  Copyright © 2017 Mebius. All rights reserved.
//

import UIKit
import WebKit

class WebPage: UIViewController {
    class func Instance() -> WebPage {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let ctrlId = String (describing: self)
        return sb.instantiateViewController(withIdentifier: ctrlId) as! WebPage
    }
    
    var page = ""
    
    @IBOutlet private var container: UIView!
    @IBOutlet private var backButton: UIButton!
    
    private var webView = WKWebView()
    private let wheel = MYWheel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container.isUserInteractionEnabled = true
        webView.navigationDelegate = self
        backButton.imageEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if page.isEmpty {
            return
        }
        NotificationCenter.default.addObserver(self, selector: #selector(httpResponse(_:)),
                                               name: Config.Notification.login, object: nil)
        User.shared.login()
    }
    
    @objc func httpResponse(_ notification:Notification) {
        NotificationCenter.default.removeObserver(self)
        let valid = notification.object as! Bool
        if (valid) {
            wheel.start()
            var request = URLRequest(url: URL(string: page)!)
            request.setValue(User.shared.token, forHTTPHeaderField: "Authorization")
            webView.load(request)
        }
        else {
            let title = notification.userInfo?.string("msg") ?? "Errore"
            let msg = notification.userInfo?.string("err") ?? "Errore sconosciuto"
            
            let alert = UIAlertController(title: title as String, message: msg  as String, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func backTapped () {
        navigationController?.popViewController(animated: true)
    }
}

extension WebPage: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        wheel.stop()
        let alert = UIAlertController(title: error.localizedDescription,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        wheel.stop()
        webView.frame = container.bounds
        container.addSubview(webView)
        container.isHidden = false
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print(navigationResponse.response)
        decisionHandler(.allow)
    }
}
