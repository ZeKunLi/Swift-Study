//
//  ViewController.swift
//  KSAlamofire
//
//  Created by 李泽昆 on 17/3/22.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var 表格: UITableView!
    var dataArr = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
       
        Alamofire.request("http://192.168.1.105:8888/GetRequest.php").responseJSON { response in
            print(response.request!)  // 原始的URL请求
           print(response.response!) // HTTP URL响应
            print(response.data!)     // 服务器返回的数据
            print("数据",response.result.value as! [String: Any])   // 响应序列化结果，在这个闭包里，存储的是JSON数据
            
            
            
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
//                    print(model)
//                }
//
//                self.表格.reloadData()
//            }
            
        }
        
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ss")
        let model:Model = dataArr[indexPath.row] as! Model
        cell.textLabel?.text = model.city
        cell.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return cell
        
    }
    
    
    func separate() -> () {
        
    }

}

 
