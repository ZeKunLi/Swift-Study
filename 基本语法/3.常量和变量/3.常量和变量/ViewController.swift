//
//  ViewController.swift
//  3.常量和变量
//
//  Created by 李泽昆 on 17/3/9.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //1 定义变量 var 之后可以修改
        //2 定义常量 let 之后不可以修改
        //3 自动推到类型 常量/变量类型会根据右测代码自动推导对应的类型。具体推导热键 {option+click}
        //4 在 Swift 对类型要求非常严格,不允许直接运算。
        // 不会做默认的隐式转化,所有的类型确定都要由程序员负责
        //5 Swift中不存在基本数据类型 ,都是结构体!
        //6 Swift 一般都是自动推导，很少自己指定类型
        //7 经量使用 let 等做修改的时候在使用 var
        
        Demo()
        demo1()
    }
    
    // MARK: 函数
    func Demo() {
        let z:Double = 10
        
        print(z)
        
        let x = 10
        var y = 20
        
        y = 100;
        
        print(x+y)
    }
    
    func demo1()  {
        
        // 类型转换
        // 1.OC (int)i  Switf Int(y)
        let x = 10
        let y = 10.11
        
        print(x+Int(y))
        
        
    }


}

