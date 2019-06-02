//
//  ViewController.swift
//  5.逻辑分支
//
//  Created by 李泽昆 on 17/3/10.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func demo2()  {
        let x = 10
        
        
        // 语法和 OC 一样
        x>5 ? print("大了"):print("小了")
        // ()表示空执行
        x>20 ? print("大了"):()
    }
    
    
    
    // MARK: 分支
    func demo () {
        
        
        let x = 100
        
        // 条件不需要（）
        // 语句必须有 {}
        // *OC没有花括号只执行一行代码
        if x<5 {
            print("小了")
        } else {
            print("大了")
        }
    }


}

