//
//  Person.swift
//  10.运行时加载属性列表 （调用 C 方法）
//
//  Created by 李泽昆 on 17/3/21.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit

class Person: NSObject {
    var name:String?
    var sax:String?
    var no:Int?
    private var title:String?
    
    /// 基本数据类型在 OC 中没有可选项，如果定义成可选项同样取不到值,使用 KVC 会崩溃!
    /// prrvate 数据类型,使用运行时机制,同样获取不到属性，OC 中可以，使用 KVC 的方式会崩溃!
    ///目标：【运行时】获取当前类的属性数组
    class func propertyList() -> ([String]) {
        
        var count:UInt32 = 0
        
        //1. 获取类的属性列表
        let list = class_copyPropertyList(self, &count)
        
        //2. 遍历数组列表
//        for i in 0..<count {
//            print("数组数量",count)
//            //3.根据下标获取属性
//            let pty = list?[Int(i)]
//            // int8 -> byte - > Char=> C语言字符串
//            let cName = property_getName(pty)
//            
//            let name = String(utf8String: cName!)
//            
//            print(name!)
//        }
        
        for i in 0..<count {
            
            //3.根据下标获取属性
            // 使用 gurad 的语法,以此判断每次播放的是否有值，如果一项没 Nil就不在执行下面的代码
            guard let pty = list?[Int(i)],
                let cName = property_getName(pty),
                let name = String(utf8String: cName)else {
                // 继续遍历下一个
                continue
            }
       
            
            print(name)
        }
        
        // C语言指针必须自己释放
        free(list)
        return []
    }
}
