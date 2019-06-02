//
//  HotViewController.swift
//  ARM
//
//  Created by 李泽昆 on 17/3/21.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit
//import Alamofire

class HotViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let kScreenHeight = UIScreen.main.bounds.size.height
    let kScreenWidth = UIScreen.main.bounds.size.width
    var tableview = UITableView()
    var dataArr = NSMutableArray()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("ze",dataArr.count)
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as!MovieTableViewCell
        let model:Model = dataArr[indexPath.row] as! Model
        cell.nickLable.text = model.city
        
        cell.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       self.present(DetailsViewController(), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUI()
//        Alamofire.request("http://116.211.167.106/api/live/aggregation?uid=133825214&interest=1").responseJSON { response in
//            //  print(response.request!)  // 原始的URL请求
//            // print(response.response!) // HTTP URL响应
//            //  print(response.data!)     // 服务器返回的数据
//            //  print(response.result)   // 响应序列化结果，在这个闭包里，存储的是JSON数据
//
//
//
//            if let JSON:[String: Any] = response.result.value as! [String : Any]? {
//
//
//                let arr = JSON["lives"] as! [Any]
//
//                for a in arr {
//                    let dic = a as![String : Any]
//
//                    let user = dic["creator"] as![String : Any]
//
//                    let model = Model()
//                    model.city = user["nick"] as! String?
//
//                    print(model.city!)
//                    self.dataArr.add(model)
//                    self.tableview.reloadData()
//                    print("conunt",self.dataArr.count)
//                }
//
//
//            }
//
//        }
        
    // funtion
        
        
    }
    
    func setUI() -> () {
        self.tableview = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.tableview.delegate = self
        self.tableview.dataSource = self
        self.tableview.register(UINib.init(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
        self.tableview.rowHeight = kScreenHeight/2 - 64
        view.addSubview(self.tableview)
   
    }
    
    func upData() -> () {
        
    }
    
    

    

}
