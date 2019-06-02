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
        //实列化 Person
        //() -> alloc/ init
        //Swift对应一个构造函数
        //作用：给成员变量分配空间，初始化属性
//        let per = Person()
//       print(per.name)
        let per = Student(no: "10", name: "lizekun")
        print(per.name,"--",per.no)
        
      
    }



}

