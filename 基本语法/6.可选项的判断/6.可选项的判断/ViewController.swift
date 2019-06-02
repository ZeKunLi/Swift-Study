//
//  ViewController.swift
//  6.可选项的判断
//
//  Created by 李泽昆 on 17/3/10.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        demo(x: 10, y: nil)
//        demo2(x: nil, y: nil)
//        demo3()
//        demo4()
        demo5(name: "老王", age: nil)
        
        
    }
    // MARK:
    func demo(x:Int?,y:Int?) {
    // 强行解包有风险 如果值为 nil: unexpectedly found nil while unwrapping an Optional value
        if x == nil || y == nil {
            print("x&y 等于空")
        } else {
            print(x!+y!)
        }
    }
    // MARK: ??
    func demo2(x:Int?,y:Int?) {
        // ?? 是一个简单的三目运算符 优先级低 加个（）转换他的优先级
        // 如果有值执行前面的代码 如果没值执行后面的代码
        
        print((x ?? 0)+(y ?? 0 ))
        
        let name:String? = "你好"
        
        print((name ?? "") + "老王")
        
        print(name ?? "" + "老王")
        
        
    }
    
    // MARK: if var/let 连用
    // 目的就是为了判断值， 如果有值进入分支。
    func demo3() {
        let oName:String? = "老王"
        let oAge:Int? = 100
        
        
        if let name = oName,
            var age = oAge {
            
            age = 1000
            print(name + String(age))
        }
        
       
    
    }
    // MARK: guard 和 if let 刚好相反  // 减少分支
    func demo4() {
        let oName:String? = "老王"
        let oAge:Int? = 100
        
        guard let name = oName, let age = oAge else {
            print("其中一个没有值")
            return
        }
        print(name + String(age))
        
    }
    
    
    // 使用同名变量接收值，在后续使用的都是非空值，不需要解包
    func demo5(name:String? , age:Int?)  {
        if let name = name ,
            let age = age{
            print(name+String(age))
        } else {
            print("其中一个没有值")
        }
        
        
        guard let name = name , let age = age else {
            print("其中一个没有值")
            return
        }
        
        print(name + String(age))
        
    }

}

