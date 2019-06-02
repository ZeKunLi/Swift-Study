//
//  ViewController.swift
//  8.构造函数
//
//  Created by 李泽昆 on 17/3/15.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit
// 在 Swift 中同一个项目中所有类都是共享的	,都可以直接访问，不需要import
// 所有所有的对象的属性 var 都可以直接访问到

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let per = Person()
        let s = Student()
        
        print(s.no)
        print(s.name)
        
        
        
      
    }



}

