//
//  SearchCell.swift
//  Doutu
//
//  Created by SNQU-IOS on 2018/7/13.
//  Copyright © 2018年 SNQU. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    
    @IBOutlet weak var faceImage: UIImageView!
    
    let mySearchModel:SearchModel! = nil

    
    func loadData(par:SearchModel) -> Void {
        self.faceImage.kf.setImage(with: URL.init(string: par.small_url))
    }
}
