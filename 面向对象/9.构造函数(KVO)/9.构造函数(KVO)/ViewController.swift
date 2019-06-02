//
//  ViewController.swift
//  9.构造函数(KVO)
//
//  Created by 李泽昆 on 17/3/17.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let per = Person(dict: ["name":"李泽昆","age":100])
        // 如果子类没有重新父类方法,调用的时候，调用的时候会做直接调用父类方法!
        let per = Student(dict: ["name":"李泽昆","age":100,"no":"1001","title":"HHXX"])
        
        print(per.name!,per.age,per.no as Any)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

