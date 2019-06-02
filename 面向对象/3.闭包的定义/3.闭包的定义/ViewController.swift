//
//  ViewController.swift
//  3.闭包的定义
//
//  Created by 李泽昆 on 17/3/14.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /**
     闭包
     1.提前准备好的代码
     2.在需要的时候执行
     3.可以当做参数传递
     4.如果有参数就带 In 没参数可以返回可是省略 In
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1> 最简单的闭包
        // () -> (),没有参数，没有返回值的函数
        let b = {
            print("hello")
        }
        
        // 执行闭包
        b()
        
        
        // 2> 带参数的闭包
        // 闭包中的参数返回值实现代码都是是实现{}中
        // 格式 {形参列表-> 返回值 in // 实现代码}
        let b2 = { (x:Int) ->() in
            print(x)
            
        }
        
        b2(10)
        
        
        let b3 = { (x:Int,y:Int) ->(Int) in
            
            return x + y
        }
        
        
        print(b3(200,200))
       
        
    }

    
    
    func demo() {
        print(sum(x: 10, y: 100))
        // 定义一个的变量记录函数
        let s = sum
        // 在需要的是时候执行
        print(s(10, 10))
    }
    
    func sum(x:Int, y:Int) -> Int {
        return x + y
    }


}

