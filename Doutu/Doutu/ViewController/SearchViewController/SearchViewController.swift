//
//  SearchViewController.swift
//  Doutu
//
//  Created by SNQU-IOS on 2018/7/13.
//  Copyright © 2018年 SNQU. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController,UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    var dataArray:[SearchModel]! = []

    var keyWord:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
    }
    
    func initView() -> Void {
        
        let width = self.view.frame.size.width / 2
        
        let flow:UICollectionViewFlowLayout = UICollectionViewFlowLayout();
        flow.scrollDirection = UICollectionViewScrollDirection.vertical
        flow.minimumLineSpacing = 0;
        flow.minimumInteritemSpacing = 0;
        flow.itemSize = CGSize(width: width, height: width)
        self.mainCollectionView.collectionViewLayout = flow;
        self.mainCollectionView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
    }
    
    override func handleData() -> Void {
        
        let url = "http://so.picasso.adesk.com/emoji/v1/resource?from=select&keyword="+self.keyWord.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!+"&limit=48&order=new&skip=0"
        NetworkTools().getTwo(url, parameters: nil) { (stute, json, content) in
            print(json!["imglist"])
            let tempArray = json!["res"]["data"]
            if tempArray.count == 0 {
                UIAlertView.init(title: "提示", message: "没有相关记录", delegate: nil, cancelButtonTitle: "取消").show()
                
            }else{
                self.dataArray.removeAll()
                for (index, _) in tempArray.enumerated() {
                    let obj = SearchModel().dics(parameter:tempArray[index]);
                    self.dataArray.append(obj)
                }
                self.mainCollectionView.reloadData()
                self.view.endEditing(true)
            }
        
        }
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.keyWord = searchBar.text;
        self.handleData()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"SearchCell", for: indexPath) as! SearchCell
        cell.loadData(par: self.dataArray[indexPath.row]);
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SearchCell
        let model:SearchModel = self.dataArray[indexPath.row]
        
        UMShareTool().shareImage(thumbImage: cell.faceImage.image!, imageUrl: model.small_url, type: UMSocialPlatformType.QQ)

        
    }

}
