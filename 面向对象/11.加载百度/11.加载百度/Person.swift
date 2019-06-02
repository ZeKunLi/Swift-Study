//
//  Person.swift
//  11.加载百度
//
//  Created by 李泽昆 on 17/3/21.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit
/**
 -遍历构造函数的目的
 1.条件判断,只有条件满足才能初始化对象,可以防止造成不必要的内存开销
 2.简化创建对象
 3.本身不负责属性的创建和初始化工作
 */
class Person: NSObject {
    var name: String?
    var age: Int = 0
    /**
     1.正常的构造函数允许返回 nil
     -正常的构造函数一定会常见对象
     -判断给定参数是否符合条件,如果不符合条件,直接返回 Nil,不会创建对象,减少内存开销!
     2.遍历构造函数使用 self.init()'构造当前对象'
     -没有convenience关键字的构造函数使用来创建对象的，反之用来检查条件,本身不负责创建对象。
     3.如果要遍历构造函数中使用当前对象属性，一定要是用 self.init 之后
    */
    
    // 遍历构造函数
    convenience init?(name: String,age: Int) {
        if age > 100 {
            return nil
        }
        // Use of 'self' in property access 'age' before self.init initializes self
        //实列化当前对象
        self.init()
        self.name = name
        self.age = age
        
    }
    
    
}
