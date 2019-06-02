//
//  ViewController.swift
//  2.函数定义
//
//  Created by 李泽昆 on 17/3/11.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(demo(x: 10, y: 10))
        print(demo2(a: 10, b: 10))
        print(demo3(3, 4))
        print(demo4())
        print(demo4(x: 0, y: 0))
    }
    // MARK:函数基本定义
    func demo(x:Int,y:Int) -> Int {
        return x + y
    }
    
    // MARK:函数的外部参数
    // 1外部参数就是在参数前面加一个参数名
    // 2不想有参数可以加个_
    // 3外部参数让外部开起来十分易懂
    func demo2(a x:Int,b y:Int) -> Int {
        return x + y
    }
    // 在swift _ 就可以表示不感兴趣的的内容
    // _代替从来没有用过的参数
    func demo3(_ x:Int,_ y:Int) -> Int {
        
        for _ in 0..<10 {
            print("😝")
        }
        return x + y
    }
    
    //MARK:默认值
    // 通过给参数任何默认值,可以任意组合，如果不指定就使用默认值。
    // ** 二 OC则需要定义很多方法，但最后都调用的用一个方法。
    func demo4(x:Int = 10, y:Int = 10) -> Int {
        return x + y
    }
    
    //MARK:无返回值
    //   主要用在闭包！！！
    //   前面执行    输出  结果
    func demo5() -> Void {
        print("😝")
    }
    func demo6() ->() {
        print("😝")
    }
    
    func demo7() {
        
    }
}

