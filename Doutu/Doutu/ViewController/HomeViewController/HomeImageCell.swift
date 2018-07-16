//
//  HomeImageCell.swift
//  Doutu
//
//  Created by SNQU-IOS on 2018/7/12.
//  Copyright © 2018年 SNQU. All rights reserved.
//

import UIKit
import Kingfisher

class HomeImageCell: UICollectionViewCell {
    @IBOutlet weak var faceImage: UIImageView!
    
    let myHomeImageModel:HomeImageModel! = nil

    
    func loadData(par:HomeImageModel) -> Void {
        self.faceImage.kf.setImage(with: URL.init(string: par.url))
    }
}
