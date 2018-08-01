//
//  MYHttp.swift
//  MysteryClient
//
//  Created by mac on 17/08/17.
//  Copyright © 2017 Mebius. All rights reserved.
//

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

enum MYHttpType {
    case grant
    case get
    case post
}

import Foundation
import Alamofire

class MYHttp {
    static let printJson = true
    
    private var json = JsonDict()    
    private var type: HTTPMethod!
    private var apiUrl = ""
    
    private var myWheel:MYWheel?
    
    init(_ httpType: MYHttpType, param: JsonDict, showWheel: Bool = true) {
        json = param
        
        switch httpType {
        case .get:
            type = .get
            apiUrl = Config.Url.get
        case .grant:
            type = .post
            apiUrl = Config.Url.grant
        case .post:
            type = .post
            apiUrl = Config.Url.post
        }
        
        self.startWheel(showWheel)
    }
    
    func load(ok: @escaping (JsonDict) -> (), KO: @escaping (String, String) -> ()) {
        printJson(json)
        var headers = [String: String]()
//        headers["content-type"] = "application/json"
        if Config.Auth.token.count > 0 {
            headers["Authorization"] = Config.Auth.header + Config.Auth.token
        }
        
        Alamofire.request(apiUrl,
                          method: type,
                          parameters: json,
                          headers: headers).responseString { response in
                            self.startWheel(false)
                            let data = self.fixResponse(response)
                            if data.isValid {
                                ok (data.dict)
                            } else {
                                KO (data.dict.string("err"), data.dict.string("msg"))
                            }
        }
    }
    
    private func fixResponse (_ response: DataResponse<String>) -> (isValid: Bool, dict: JsonDict) {
        let statusCode = response.response?.statusCode
        let array = apiUrl.components(separatedBy: "/")
        let page = array.last ?? apiUrl
        
        if response.result.isSuccess && statusCode == 200 {
            let dict = removeNullFromJsonString(response.result.value!)
            printJson(dict)
            return (true, dict)
        }
        let errorMessage = response.error == nil ? "Server error" :  (response.error?.localizedDescription)!
        let dict = [ "err" : "Server error \(statusCode ?? 0)\n[ \(page) ]", "msg" : errorMessage ]
        return (false, dict)
    }
    
    private func removeNullFromJsonString (_ text: String) -> JsonDict {
        if text.isEmpty {
            return [:]
        }
        let jsonString = text.replacingOccurrences(of: ":null", with: ":\"\"")
        if let data = jsonString.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! JsonDict
            } catch {
                print(error.localizedDescription)
            }
        }
        return [:]
    }
    
    // MARK: - private
    
    fileprivate func printJson (_ json: JsonDict) {
        if MYHttp.printJson {
            print("\n[ \(apiUrl) ]\n\(json)\n------------")
        }
    }
    
    fileprivate func startWheel(_ start: Bool, inView: UIView = UIApplication.shared.keyWindow!) {
        if start {
            myWheel = MYWheel()
            myWheel?.start(inView)
        }
        else {
            if let wheel = myWheel {
                wheel.stop()
                myWheel = nil
            }
        }
    }
}
