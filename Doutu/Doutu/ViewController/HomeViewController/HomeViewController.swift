//
//  HomeViewController.swift
//  Doutu
//
//  Created by SNQU-IOS on 2018/7/12.
//  Copyright © 2018年 SNQU. All rights reserved.
//

import UIKit


class HomeViewController: BaseViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    var dataArray:[HomeImageModel]! = []
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let footer = MJRefreshAutoNormalFooter()
    var index = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.handData(page: index)
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
        
        self.footer.setRefreshingTarget(self, refreshingAction: Selector(("footerRefresh")))
        
        self.footer.beginRefreshing {
            print("上拉刷新")
            self.index = self.index + 1
            self.handData(page: self.index)
        }
        self.mainCollectionView.mj_footer = self.footer
    }
    
    
    func handData(page:Int) -> Void {
        let url = "/macpicface/interface/query_dt.php?cands=5AsN5A626yo95zYO5y_r&tp=1&page="+String(page)+"&tid=-1";
        NetworkTools.shared.get(url, parameters: nil, needHeaders: true, needLoading: false) { (status, json, content) in
            if json == nil {
                self.index = self.index - 1
                self.mainCollectionView.mj_footer.endRefreshing()
                return
            }
//            print(json!["imglist"])
            let tempArray = json!["imglist"]
            
            for (index, _) in tempArray.enumerated() {
                let obj = HomeImageModel().dics(parameter:tempArray[index]);
                self.dataArray.append(obj)
            }
            self.mainCollectionView.mj_footer.endRefreshing()
            self.mainCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataArray.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HomeImageCell", for: indexPath) as! HomeImageCell
        cell.loadData(par: self.dataArray[indexPath.row]);
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomeImageCell
        let model:HomeImageModel = self.dataArray[indexPath.row]
        
        UMShareTool().shareImage(thumbImage: cell.faceImage.image!, imageUrl: model.url, type: UMSocialPlatformType.QQ)
//        let urls = NSURL(string: "")
//        let urlString = "myqq://"
//        if let url = URL(string: urlString) {
//            //根据iOS系统版本，分别处理
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url, options: [:],
//                                          completionHandler: {
//                                            (success) in
//                })
//            } else {
//                UIApplication.shared.openURL(url)
//            }
//        }
        
    }

}
