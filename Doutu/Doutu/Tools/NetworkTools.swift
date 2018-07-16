//
//  NetworkTools.swift
//  Doutu
//
//  Created by SNQU-IOS on 2018/7/12.
//  Copyright © 2018年 SNQU. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// - success: 响应成功
// - unusual: 响应异常
// - failure: 请求错误
enum ResponseStatus:Int {
    case success = 0
    case unusual = 1
    case failure = 3
}

typealias NetworkFinished = (_ status:ResponseStatus, _ result: JSON?, _ tipString: String?) -> ()

class NetworkTools: NSObject {
    static let shared = NetworkTools()
    
    var rootDomain : String{
        
        return "http://config.pinyin.sogou.com";
    }
}

extension NetworkTools{
    func get(_ APIString: String, parameters: [String : Any]?, needHeaders: Bool = true, needLoading: Bool = false, finished: @escaping NetworkFinished) {
        
        let headers = needHeaders ? self.headers() : nil
        
        Alamofire.request(rootDomain + APIString, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            self.handle(response: response, finished: finished, needLoading: needLoading)
        }
        
    }
    
    func getTwo(_ APIString: String, parameters: [String : Any]?, needHeaders: Bool = true, needLoading: Bool = false, finished: @escaping NetworkFinished) {
        
        let headers = needHeaders ? self.headers() : nil
        
        Alamofire.request(APIString, method: .get, parameters: parameters, headers: headers).responseJSON { (response) in
            self.handle(response: response, finished: finished, needLoading: needLoading)
        }
        
    }
    
    
    fileprivate func handle(response: DataResponse<Any>, finished: @escaping NetworkFinished, needLoading: Bool) {
        switch response.result {
        case .success(let value):
            let json = JSON(value)
            finished(.unusual, json, json.string)
        case .failure(let error):
            finished(.failure, nil, error.localizedDescription)
        }
    }
    
    fileprivate func headers() -> Dictionary<String, String>! {
        
        let acceptLanguage = Locale.preferredLanguages
            .prefix(6)
            .enumerated()
            .map { index, languageCode in
                let quality = 1.0 - (Double(index) * 0.1)
                return "\(languageCode),q=\(quality)"
            }
            .joined(separator: ", ")
        
        let userAgent: String = {
            if let info = Bundle.main.infoDictionary {
                return "HEXA/iOS/" + (info["CFBundleShortVersionString"] as? String ?? "Unknown")
            }
            return "HEXA/iOS/Unknown"
        }()
        
        return [
            "Accept-Encoding": "gzip;q=1.0, compress;q=0.5",
            "Accept-Language": acceptLanguage,
            "User-Agent": userAgent,
            "X-App-OSVersion": UIDevice.current.systemVersion,
            "X-App-Device": UIDevice.current.model,
            //        "X-User-AccessToken": UserDefaults.standard.string(forKey: ACCESSTOKEN_KEY) ?? ""
        ]
    }

    
}
