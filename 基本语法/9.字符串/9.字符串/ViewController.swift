//
//  ViewController.swift
//  9.字符串
//
//  Created by 李泽昆 on 17/3/10.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // String 是一个结构体，性能更高,String 支持遍历
        demo5 ()
    }
    // MARK:遍历字符串
    func demo () {
        
        // NSString 不支持遍历
        let str:String  = "我要飞得更高"
        
        for c in str.characters {
            print(c)
        }
        
    }
    // MARK:计算字符串长度
    func demo2 () {
        
        let  str = "hello world我"
        // 返回指定编码的对应的字节数量
        // UTF-8 的编码0-4个字节 ,每个汉字是3个字节
        print(str.lengthOfBytes(using: .utf32))
        // 字符串长度 - 返回字符的个数
        print(str.characters.count)
        // 使用 NSString 中转
        // as 是做类型转换的 as(作为)
        let ocString = str as NSString
        
        print(ocString.length)

    }
    // MARK:拼接字符串
    func demo3 () {
        let name = "老王"
        let age = 20
        let title:String? = nil
        let point = CGPoint(x: 20, y: 20)
        
        let str = "\(name) \(age) \(title ?? "") \(point)"
        print(str)
  
        
    }
    
    // MARK:格式化
    func demo4 () {
        let h = 10
        let m = 1
        let s = 20
        
        print("\(h):\(m):\(s)")
        
        let str = String(format: "%ld:%ld:%ld", h,m,s)
        
        print(str)
        
        
    }
    
    // MARK:字符串子串
    func demo5 () {
        //1 建议用 NSString作为中转,应为  Swift String一在优化不好理解
        let str = "我们一起飞"
        
        
        let ocString = str as(NSString)
        
        let s1 = ocString.substring(with: NSMakeRange(0, 4))
        print(s1)
        
        
        //2 Swift3.0方法
        //                     ↘️字符串于原字符串没关系
        let s2 = str.substring(to: "我们".endIndex)
        let s3 = str.substring(to: "123".endIndex)
        
        
        print(s2 + "+" + s3 )
        
        
        // 比较方便 但是不好理解  偶尔使用方便
        guard let ss = str.range(of: "我们") else {
            return
        }
        print("-----")
        //一定找到的范围
        print(str.substring(with: ss))

        print(ss)
        
        
        
    }

}

