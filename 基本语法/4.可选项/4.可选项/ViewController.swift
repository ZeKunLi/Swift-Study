//
//  ViewController.swift
//  4.可选项
//
//  Created by 李泽昆 on 17/3/9.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        demo()
        demo1()
        option()
        
    }
    func demo1 () {
        // ** let 常量可选项没有默认值
        // ** var 变量可选项有默认值 默认值为 Nil
        let x:Int?
        
        
        x = 20
        
        print(x!)
        
        var y:Int?
        
        print(y)
        
        
        
        
    }
    
    func option() {
        var optionalInteger : Int?
        var optionalInterger :Optional<Int>
        
        optionalInteger = 42
        print(optionalInteger!)
        
        
        var optionArray : ([Int])?
        
        var string :String?
        
        if string != nil {
            print(string)
        } else {
            print("字符串为空")
        }
        
//        var myString:String!
//
//        myString = "Hello, Swift!"
//
//        if myString != nil {
//            print(myString)
//        }else{
//            print("myString 值为 nil")
//        }
    
        
        var myString :String?
        
        
        myString  = "Hello Swift.";
        
        
        if let yourString = myString {
            print("你的字符串值为\(yourString)")
        } else {
            print("你的字符串没有值")
        }
        
        
        

        
        
    }
    func demo () {
        
        // 原始的可选项定义
        let x: Optional = 10
        // 简单的可选项定
        // 常量使用之前必须初始化
        // ？用来定义Y是一个可选int 类型,可能没有值,也可能有一个整数。
        let y:Int? = 20;
        
        
        // 可选项计算之前必须强行解包。
        // 不同类型之间的值不能直接运算!如果没有值是 nil ,nil 不是任何数据类型不能参与运算。
        // ! 表示强行解包-从可选值中强行获取对应的!nil值,如果真为 Nil,就会崩溃
        // 程序员要为每个！号负责
        print(y!+x!)
        
    
        
    }


}

