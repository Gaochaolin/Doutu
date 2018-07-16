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
    var dataArray2:[HomeImageModel]! = []

    var lastButton:UIButton! = nil
    var currentButton:UIButton! = nil
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    let footer = MJRefreshAutoNormalFooter()
    var index = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lastButton = self.view.viewWithTag(200) as! UIButton
        self.handData(page: index, type:self.lastButton.tag - 200)
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
            self.handData(page: self.index,type: self.lastButton.tag - 200)
        }
        self.mainCollectionView.mj_footer = self.footer
    }
    
    @IBAction func clickButton(_ sender: UIButton) {
        if self.lastButton == sender {
            return
        }
        self.lastButton = self.currentButton
        self.currentButton = sender
        
        self.lastButton.setTitleColor(UIColor.init(red: 119, green: 119, blue: 119, alpha: 1), for: UIControlState.normal)
        self.currentButton.setTitleColor(UIColor.init(red: 255, green: 82, blue: 111, alpha: 1), for: UIControlState.normal)
        self.handData(page: 1, type: self.currentButton.tag - 200)
    }
    
    func handData(page:Int ,type:NSInteger) -> Void {
        var url = "/macpicface/interface/query_dt.php?cands=5AsN5A626yo95zYO5y_r&tp=1&page="+String(page)+"&tid=-1";
        if type == 1{
            url = "/macpicface/interface/query_dt.php?cands=5PAx5zU_5BQu562u&tp=1&page="+String(page)+"&tid=1033"
        }
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
                if type == 0{
                    self.dataArray.append(obj)
                }else if type == 1{
                    self.dataArray2.append(obj)
                }
            }
            self.mainCollectionView.mj_footer.endRefreshing()
            self.mainCollectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = self.currentButton.tag - 200
        switch type {
        case 0 :
            return self.dataArray.count;
        case 1:
            return self.dataArray2.count;
        default:
            return 0;
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"HomeImageCell", for: indexPath) as! HomeImageCell
        var tempArray:[HomeImageModel] = []
        let type = self.currentButton.tag - 200
        switch type {
        case 0:
            tempArray = self.dataArray
            break;
        case 1:
            tempArray = self.dataArray2
            break;
        default:
            tempArray = []
        }
        cell.loadData(par: tempArray[indexPath.row]);
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! HomeImageCell
        
        let model:HomeImageModel = cell.myHomeImageModel
        
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
