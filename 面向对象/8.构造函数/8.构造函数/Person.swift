//
//  Person.swift
//  8.构造函数
//
//  Created by 李泽昆 on 17/3/15.
//  Copyright © 2017年 Frank-Lee. All rights reserved.
//

import UIKit
/**
 1.给自己的属性分配空间并且设置初始值
 2.调用父类的'构造函数'的目的给父类的属性分配空间设置初始者
 NSObject没有属性,只有一个成员变量 'isa'
 */
class Person: NSObject {
    // 在非 Opertion 选项中 必须先初始化对象
    var name:String
    
        //Overriding declaration requires an 'override' keyword
        //Overrid 需要 声明一个重新的关键字
        // 1 重写就是父类有这个方法 子类重新实现 
     override init() {
        // Nil cannot be assigned to type 'String'
        // nil 不能出声
//         name = nil不能指定为  String 类型 
        name = "Chainsmokers"
        super.init()
        //  Property 'self.name' not initialized at super.init call
        //  self.name 属性在调用父类构造函数没有被初始化
//        name = "李泽昆"
    }
    
    

}
