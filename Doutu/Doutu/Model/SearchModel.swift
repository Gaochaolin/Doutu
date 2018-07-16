//
//  SearchModel.swift
//  Doutu
//
//  Created by SNQU-IOS on 2018/7/13.
//  Copyright © 2018年 SNQU. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchModel: NSObject {
    var height:String = "";
    var width:String = "";
    var small_url:String = "";
    
    
    func dics(parameter:(JSON))->SearchModel {
        self.height = parameter["height"].stringValue
        self.width = parameter["width"].stringValue
        self.small_url = parameter["small_url"].stringValue
        return self;
    }
}
