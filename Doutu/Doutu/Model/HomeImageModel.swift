//
//  HomeImageModel.swift
//  Doutu
//
//  Created by SNQU-IOS on 2018/7/12.
//  Copyright © 2018年 SNQU. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeImageModel: NSObject {
    var height:String = "";
    var id:String = "";
    var width:String = "";
    var cid:String = "";
    var size:String = "";
    var keywords:String = "";
    var imageSource:String = "";
    var url:String = "";
    
    
    func dics(parameter:(JSON))->HomeImageModel {
        self.height = parameter["height"].stringValue
        self.id = parameter["id"].stringValue
        self.width = parameter["width"].stringValue
        self.cid = parameter["cid"].stringValue
        self.size = parameter["size"].stringValue
        self.keywords = parameter["keywords"].stringValue
        self.imageSource = parameter["imageSource"].stringValue
        self.url = parameter["url"].stringValue
        return self;
    }
}
