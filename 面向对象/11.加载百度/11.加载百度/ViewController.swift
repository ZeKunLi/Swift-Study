//
//  ViewController.swift
//  11.加载百度
//
//  Created by 李泽昆 on 17/3/21.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // URL构造函数可以返回 nil
        // 构造函数就是返回实列化对象!
        // init?(string: String) :构造函数可以返回 Nil
        let url = URL(string: "http://www.baidu.com")
        
        URLSession.shared.dataTask(with: url!) { (data, _, error) in
            
//            if error != nil {
//                print("数据安全出错")
//            }
            
            guard let data = data else {
                print("网络请求失败")
                return
            }
            
//            let html = String(data: data, encoding: .utf8)
            
//            print(html!)
            
        }.resume()
        
        
        let per = Person(name: "李泽昆", age: 2000)
        print("-------")
        
        print(per?.age)
        
        
    }
   


}

