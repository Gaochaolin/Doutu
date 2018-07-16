//
//  UMShareTool.swift
//  Doutu
//
//  Created by SNQU-IOS on 2018/7/13.
//  Copyright © 2018年 SNQU. All rights reserved.
//

import UIKit

class UMShareTool: NSObject {
    
    func shareImage(thumbImage:UIImage,imageUrl:String,type:UMSocialPlatformType) -> Void {
        
        let shareImage = NSData.init(contentsOf: URL.init(string: imageUrl)!)
        let shareObject:UMShareImageObject = UMShareImageObject.init();
            shareObject.thumbImage = shareImage
            shareObject.shareImage = shareImage
        
        

        

        let messageObject:UMSocialMessageObject = UMSocialMessageObject.init()
            messageObject.title = "QAQ分享"
            messageObject.shareObject = shareObject
        
        
        UMSocialManager.default().share(to: type, messageObject: messageObject, currentViewController: nil) { (shareResponse, error) in
//            NSLog("%s", errorr.der)
            if error != nil {
                print("Share Fail with error ：%@", error as Any)
            }else{
//                self?.getUserInfoForPlatform(platformType: platformType)
                print("Share succeed")
            }
            
        }
    }
    
    
}
