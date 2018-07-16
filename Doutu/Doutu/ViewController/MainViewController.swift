//
//  MainViewController.swift
//  Doutu
//
//  Created by SNQU-IOS on 2018/7/12.
//  Copyright © 2018年 SNQU. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerUM()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func registerUM()->Void{
        let url = "http://www.snto.com"
        UMSocialManager.default().openLog(true)
        UMSocialManager.default().umSocialAppkey = "591a77a72ae85b76bb00015d"
        UMSocialManager.default().setPlaform(UMSocialPlatformType.QQ, appKey: "1106091425", appSecret: "941fc2fe68b8793c1f688e879315e6ed", redirectURL: url)
        UMSocialManager.default().setPlaform(UMSocialPlatformType.wechatSession, appKey: "wxd009b4125786d152", appSecret: "a4f308163777de50fecfc320faef211a", redirectURL: url)
    }
  

}
