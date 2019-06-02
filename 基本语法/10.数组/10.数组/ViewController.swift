//
//  ViewController.swift
//  10.数组
//
//  Created by 李泽昆 on 17/3/10.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        demo5()
    }
    // MARK:定义数组
    func demo () {
        
        //  跟 OC 一样 没有 ‘@‘
        //  基本数组类型不需要包装
        //
//        let array = ["ss","fs","fs",2] as [Any]
//  
//        let array1 = [1,12,34]
        // 给数组进行初始化
//        var array = [Int] ()
        let p = CGPoint(x: 10, y: 10)
        // CG结构体也不需用包装
        // Heterogenous collection literal could only be inferred to '[Any]'; add explicit type annotation if this is intentional  需要转换为[Any]类型
        //Type of expression is ambiguous without more context
        let array2 = [p,"ss",22] as [Any]  // 需要转换为[Any]类型
      
        print(array2)
     
        
    }
    // MARK:数组遍历
    func demo2()  {
        let array = ["校长","老师","学生"]
        //1 按照下标遍历
        for i in 0..<array.count {
            print(array[i])
        }
        print("-------")
        //2 for in 遍历元素
        for i in array {
            print(i)
        }
        print("-------")
        //3 enum block 遍历, 同时遍历下标和内容
        
        // 元祖  i: (offset: Int, element: String)
        for i in array.enumerated() {
            print(i)
        }
        //4 遍历下标和内容2
        // n是索引下标 s String
        for (n, c) in array.enumerated() {

            print("\(n): '\(c)'")
        }
        print("-------")
        // 5反序遍历
        for i in array.reversed() {
            print(i)
        }
        
        // 6反序索引内容和下标
        
        // 先枚举 在反序
        for i in array.enumerated().reversed() {
            print(i)
        }
        
        for (n,s) in array.enumerated() {
            print("\(n) + \(s)")
        }
        
    }
    
    // MARK:数组的增删改 
    func demo3 () {
        var array = ["校长","老师","学生"]
        // 添加数组
        array.append("督查")
        // 移除数组
        array.remove(at: 2)
        // fatal error: Index out of range 数组
        // 修改元素
        array[1] = "狗"
        print(array)
        
    }
    
    // MARK:数组容量
    func demo4 () {
        // 定义一个数组 指定类型是存放 Int 的数组 ,但是没有初始化
//        var array:[Int]
        // 给数组进行初始化
//        array = [Int]()
        
        // 讲两句合并成一句
        var array = [Int]()
        
        // 注意 ： 插入元素时如果容量不够会默认给 * 2 (0.初始第一次默认就是2）
        // 容量不足时每次会*2 会提高效率 不用每次初始化
        
        for i in 0...8 {
            array.append(i)
            print("\(array) \(array.capacity)")
        }
        
    }
    
    // MARK:数组合并
    func demo5 () {
        var arr:[Any] = ["数据","网络","UI"]
        let arr2 = ["流媒体",3] as [Any]
        
        arr += arr2
        print(arr)
        
        
    }


}

